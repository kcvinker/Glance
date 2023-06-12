
# contextmenu module - Created on 29-Apr-2023 16:45 [ Added to Glance on 06-Jun-2023 22:08]
# This module is included at the end of controls.nim

# const
    # TPM_LEFTBUTTON = 0x0000
    # TPM_RIGHTBUTTON = 0x0002

# You might ask why did functions are scattered around in this module.
# Well, this is Nim. We can't place related functions in a single location.
# Forward declaration is another hack, but i don't want to do that.
proc getMenuItem(this: ContextMenu, idNum: int32): MenuItem =
    for menu in this.mMenus:
        if menu.mId == idNum: return menu

proc getMenuItem(this: ContextMenu, txt: ref Wstring): MenuItem =
    for menu in this.mMenus:
        if menu.mText == txt[]: return menu

proc cmenuWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.} =
    var this = cast[ContextMenu](refData)
    case msg
    of WM_DESTROY:
        DestroyMenu(this.mHmenu)
        RemoveWindowSubclass(hw, cmenuWndProc, scID)


    of WM_MEASUREITEM:
        var pmi = cast[LPMEASUREITEMSTRUCT](lpm)
        pmi.itemWidth = UINT(this.mWidth)
        pmi.itemHeight = UINT(this.mHeight)
        return 1

    of WM_DRAWITEM:
        var dis = cast[LPDRAWITEMSTRUCT](lpm)
        var mi = cast[MenuItem](cast[PVOID](dis.itemData))
        var txtClrRef : COLORREF = mi.mFgColor.cref

        if dis.itemState == 257:
            # var rc : RECT
            if mi.mIsEnabled:
                let rc = RECT(left: dis.rcItem.left + 4, top: dis.rcItem.top + 2,
                              right: dis.rcItem.right, bottom: dis.rcItem.bottom - 2)
                FillRect(dis.hDC, rc.unsafeAddr, this.mHotBgBrush)
                FrameRect(dis.hDC, rc.unsafeAddr, this.mBorderBrush)
                txtClrRef = 0x00000000
            else:
                FillRect(dis.hDC, dis.rcItem.unsafeAddr, this.mGrayBrush)
                txtClrRef = this.mGrayCref
        else:
            FillRect(dis.hDC, dis.rcItem.unsafeAddr, this.mDefBgBrush)
            if not mi.mIsEnabled: txtClrRef = this.mGrayCref

        SetBkMode(dis.hDC, 1)
        dis.rcItem.left += 25
        SelectObject(dis.hDC, this.mFont.handle)
        SetTextColor(dis.hDC, txtClrRef)
        DrawTextW(dis.hDC, mi.mWideText, -1, dis.rcItem.unsafeAddr, DT_LEFT or DT_SINGLELINE or DT_VCENTER)
        return 0

    of WM_ENTERMENULOOP:
            if this.onMenuShown != nil: this.onMenuShown(this, newEventArgs())

    of WM_EXITMENULOOP:
        if this.onMenuClose != nil: this.onMenuClose(this, newEventArgs())

    of WM_MENUSELECT:
        let idNum = int32(LOWORD(wpm))
        let hMenu = cast[HMENU](lpm)
        if hMenu != nil and idNum > 0:
            var menu = this.getMenuItem(idNum)
            if menu != nil and menu.mIsEnabled:
                if menu.onFocus != nil: menu.onFocus(menu, newEventArgs())

    of WM_COMMAND:
        let idNum = int32(LOWORD(wpm))
        if idNum > 0:
            var menu = this.getMenuItem(idNum)
            if menu != nil and menu.mIsEnabled:
                if menu.onClick != nil: menu.onClick(menu, newEventArgs())

    else: return DefSubclassProc(hw, msg, wpm, lpm)
    return DefSubclassProc(hw, msg, wpm, lpm)


proc setContextMenuItem(this: ContextMenu, item: ref Wstring ) =
    let mtyp = if ord(item[0]) == 48: mtContextSep else: mtContextMenu
    var mi = newMenuItem(item, mtyp, this.mHmenu, this.mMenuCount)
    this.mMenuCount += 1
    if mtyp == mtContextMenu:
        mi.insertMenuInternal(this.mHMenu)
        this.mMenus.add(mi)
    elif mtyp == mtSeparator:
        AppendMenuW(this.mHmenu, MF_SEPARATOR, 0, nil)

proc newContextMenu*(parent: Control, menuItems: LPCWSTR = nil): ContextMenu {.exportc:"newContextMenu", stdcall, dynlib.} =
    new(result)
    result.mParent = parent
    result.mHmenu = CreatePopupMenu()
    result.mWidth = 120
    result.mHeight = 25
    result.mRightClick = true
    result.mFont = parent.mFont
    # result.mMenus = @[]
    result.mDefBgBrush = newColor(0xe9ecef).makeHBRUSH()
    result.mHotBgBrush = newColor(0x90e0ef).makeHBRUSH()
    result.mBorderBrush = newColor(0x0077b6).makeHBRUSH()
    # result.mSelTxtClr = newColor(0x000000)
    result.mGrayBrush = newColor(0xced4da).makeHBRUSH()
    result.mGrayCref = newColor(0x979dac).cref

    let pHwnd = if parent.mKind == ctForm: parent.mHandle else: parent.mParent.mHandle
    let hinst = if parent.mKind == ctForm: cast[Form](parent).hInstance else: parent.mParent.hInstance
    result.mDummyHwnd = CreateWindowExW(0, "Button".toWcharPtr(), nil, WS_CHILD, 0, 0, 0, 0, pHwnd, nil, hinst, nil)
    SetWindowSubclass(result.mDummyHwnd, cmenuWndProc, globalSubClassID, cast[DWORD_PTR](cast[PVOID](result)))
    globalSubClassID += 1
    if menuItems != nil:
        var menuNames = splitWstring2(toWstring2(menuItems), pipeChar)
        for name in menuNames:
            result.setContextMenuItem(name)




proc addContextMenuItem(this: ContextMenu, item: LPCWSTR){.exportc:"addContextMenuItem", stdcall, dynlib.} =
    var itemTxt = toWstring2(item)
    this.setContextMenuItem(itemTxt)

proc addContextMenuItems(this: ContextMenu, item: LPCWSTR){.exportc:"addContextMenuItems", stdcall, dynlib.} =
    var itemList = splitWstring2(toWstring2(item), ord('|'))
    for i in itemList:
        this.setContextMenuItem(i)






proc showMenu(this: ContextMenu, lpm: LPARAM) =
    var pt = getMousePos(lpm)
    if pt.x == -1 or pt.y == -1:
        # ContextMenu message generated by keybord shortcut.
        # So we need to find the mouse position.
        pt = getMousePosOnMsg()

    let mBtn : UINT = if this.mRightClick: TPM_RIGHTBUTTON else: TPM_LEFTBUTTON
    TrackPopupMenu(this.mHMenu, mBtn, pt.x, pt.y, 0, this.mDummyHwnd, nil)

proc menus*(this: ContextMenu): seq[MenuItem] = return this.mMenus


proc setContextMenuEvents(this: Control, menuName: LPCWSTR, eventIndex: int, funcPtr: MenuEventHandler) {.
                                                        exportc:"setContextMenuEvents", stdcall, dynlib.} =
    var menuText = toWstring2(menuName)
    var menu = this.mContextMenu.getMenuItem(menuText)
    if menu != nil:
        let event = cast[MenuEvents](eventIndex)
        case event
        of meMiClick: menu.onClick = funcPtr
        of meMiPopup: menu.onPopup = funcPtr
        of meMiCollapse: menu.onCollapse = funcPtr
        of meMiFocus: menu.onFocus = funcPtr




