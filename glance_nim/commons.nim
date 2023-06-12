# commons module - Created on 26-Mar-2023 07:05 PM
# This module implements common functions & declarations.

# Window style combinations
let fixedSingleExStyle : DWORD = WS_EX_LEFT or WS_EX_LTRREADING or WS_EX_RIGHTSCROLLBAR or WS_EX_WINDOWEDGE or WS_EX_CONTROLPARENT or WS_EX_APPWINDOW
let fixedSingleStyle : DWORD = WS_OVERLAPPED or WS_TABSTOP or WS_MAXIMIZEBOX or WS_MINIMIZEBOX or WS_GROUP or WS_SYSMENU or WS_DLGFRAME or WS_BORDER or WS_CAPTION or WS_CLIPCHILDREN or WS_CLIPSIBLINGS
let fixed3DExStyle : DWORD = WS_EX_LEFT or WS_EX_LTRREADING or WS_EX_RIGHTSCROLLBAR or WS_EX_WINDOWEDGE or WS_EX_CLIENTEDGE or WS_EX_CONTROLPARENT or WS_EX_APPWINDOW or WS_EX_OVERLAPPEDWINDOW
let fixed3DStyle : DWORD = WS_OVERLAPPED or WS_TABSTOP or WS_MAXIMIZEBOX or WS_MINIMIZEBOX or WS_GROUP or WS_SYSMENU or WS_DLGFRAME or WS_BORDER or WS_CAPTION or WS_CLIPCHILDREN or WS_CLIPSIBLINGS
let fixedDialogExStyle : DWORD = WS_EX_LEFT or WS_EX_LTRREADING or WS_EX_RIGHTSCROLLBAR or WS_EX_DLGMODALFRAME or WS_EX_WINDOWEDGE or WS_EX_CONTROLPARENT or WS_EX_APPWINDOW
let fixedDialogStyle : DWORD = WS_OVERLAPPED or WS_TABSTOP or WS_MAXIMIZEBOX or WS_MINIMIZEBOX or WS_GROUP or WS_SYSMENU or WS_DLGFRAME or WS_BORDER or WS_CAPTION or WS_CLIPCHILDREN or WS_CLIPSIBLINGS
let normalWinExStyle : DWORD = WS_EX_LEFT or WS_EX_LTRREADING or WS_EX_RIGHTSCROLLBAR or WS_EX_WINDOWEDGE or WS_EX_CONTROLPARENT or WS_EX_APPWINDOW
let normalWinStyle : DWORD = WS_OVERLAPPEDWINDOW or WS_TABSTOP or  WS_CLIPCHILDREN or WS_CLIPSIBLINGS
let fixedToolExStyle : DWORD = WS_EX_LEFT or WS_EX_LTRREADING or WS_EX_RIGHTSCROLLBAR or WS_EX_TOOLWINDOW or WS_EX_WINDOWEDGE or WS_EX_CONTROLPARENT or WS_EX_APPWINDOW
let fixedToolStyle : DWORD = WS_OVERLAPPED or WS_TABSTOP or WS_MAXIMIZEBOX or WS_MINIMIZEBOX or WS_GROUP or WS_SYSMENU or WS_DLGFRAME or WS_BORDER or WS_CAPTION or WS_CLIPCHILDREN or WS_CLIPSIBLINGS
let sizableToolExStyle : DWORD = WS_EX_LEFT or WS_EX_LTRREADING or WS_EX_RIGHTSCROLLBAR or WS_EX_TOOLWINDOW or WS_EX_WINDOWEDGE or WS_EX_CONTROLPARENT or WS_EX_APPWINDOW
let sizableToolStyle : DWORD = WS_OVERLAPPED or WS_TABSTOP or WS_MAXIMIZEBOX or WS_MINIMIZEBOX or WS_GROUP or WS_THICKFRAME or WS_SYSMENU or WS_DLGFRAME or WS_BORDER or WS_CAPTION or WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN or WS_CLIPSIBLINGS

const # These 4 constants are used by ListView
    HDM_FIRST = 0x1200
    HDM_LAYOUT = HDM_FIRST+5
    HDM_HITTEST = HDM_FIRST+6
    HDM_GETITEMRECT = HDM_FIRST+7



# Font related functions
const
    LOGPIXELSY = 90
    DEFAULT_CHARSET = 1
    OUT_STRING_PRECIS = 1
    CLIP_DEFAULT_PRECIS = 0
    DEFAULT_QUALITY = 0

let CLR_WHITE = newColor(0xFFFFFF)
let CLR_BLACK = newColor(0x000000)


proc newFont*(fname: Wstring, fsize: int32, fweight: FontWeight = FontWeight.fwNormal,
                italic: bool = false, underline: bool = false, strikeout: bool = false) : Font =
    new(result)
    if fname.len > 32 : raise newException(OSError, "Length of font name exceeds 32 characters")
    result.name = fname
    result.size = fsize
    result.weight = fweight
    result.italics = italic
    result.underLine = underline
    result.strikeOut = strikeout
    # echo "font creation success"

proc createHandle(this: Font, hw: HWND) =
    var hdc = GetDC(hw);
    let iHeight = -MulDiv(this.size, GetDeviceCaps(hdc, LOGPIXELSY), 72)
    ReleaseDC(hw, hdc)
    # var fname = newWideCString(this.name)
    var lf : LOGFONTW
    lf.lfItalic = cast[BYTE](this.italics)
    lf.lfUnderline = cast[BYTE](this.underLine)
    for i, v in this.name :
        lf.lfFaceName[i] = v

    lf.lfHeight = iHeight
    lf.lfWeight = cast[LONG](this.weight)
    lf.lfCharSet = cast[BYTE](DEFAULT_CHARSET)
    lf.lfOutPrecision = cast[BYTE](OUT_STRING_PRECIS)
    lf.lfClipPrecision = cast[BYTE](CLIP_DEFAULT_PRECIS)
    lf.lfQuality = cast[BYTE](DEFAULT_QUALITY)
    lf.lfPitchAndFamily = 1
    this.handle = CreateFontIndirectW(lf.unsafeAddr)

# End of Font related area

# Some control needs to extract mouse position from lparam value.
proc getMousePos(lpm: LPARAM): POINT = POINT(x: int32(LOWORD(lpm)), y: int32(HIWORD(lpm)))

proc getMousePosOnMsg(): POINT =
    let dw_value = GetMessagePos()
    result.x = LONG(LOWORD(dw_value))
    result.y = LONG(HIWORD(dw_value))


#===========================================MENU SECTION==============================================
var staticMenuID : int32 = 100

proc addMenu*(this: MenuBar, txt: ref Wstring, txtColor: uint = 0x000000): MenuItem {.exportc:"menubarAddMenu", stdcall, dynlib, discardable.}
proc newMenuBar(parent: Form, menuNames: LPWSTR ) : MenuBar {.exportc:"newMenuBarPtr", stdcall, dynlib.} =
    new(result)
    result.mHmenubar = CreateMenu()
    result.mParent = parent
    result.mFont = parent.mFont
    result.mType = mtBaseMenu
    result.mMenuCount = 0
    parent.mMenuGrayBrush = newColor(0xced4da).makeHBRUSH()
    parent.mMenuGrayCref = newColor(0x979dac).cref
    parent.mMenu = result
    if menuNames != nil:
        try:
            var rawNames = toWstring2(menuNames)
            #echo "mn ", rawNames[].repr
            var nameSeq = splitWstring2(rawNames, pipeChar)        
            for i, name in nameSeq:
                #var menuname: Wstring = nameSeq[i]
                #echo "mn ", menuname.repr
                result.addMenu(name)
            #echo "tfix_", $nameSeq.len
        except CatchableError as ex:
          echo "An exception occurred:", ex.msg
          echo "Exception type:", ex.type
          #echo "Stack trace:", ex.traceback
        finally:
          echo "Execution completed"


        




proc newMenuItem*(txt: ref Wstring, typ: MenuType, parentHmenu : HMENU,
                    indexNum: int32): MenuItem =
    new(result)
    result.mPopup = if typ == mtBaseMenu or typ == mtPopup: true else: false
    result.mHmenu = if result.mPopup : CreatePopupMenu() else: CreateMenu()
    result.mIndex = indexNum
    result.mId = staticMenuID
    result.mText = txt[]
    result.mWideText = result.mText[0].addr
    result.mType = typ
    result.mParentHmenu = parentHmenu
    result.mBgColor = newColor(0xe9ecef)
    result.mFgColor = newColor(0x000000)
    result.mIsEnabled = true
    staticMenuID += 1

proc insertMenuInternal(this: MenuItem, parentHmenu: HMENU) =
    var mii : MENUITEMINFOW
    mii.cbSize = cast[UINT](mii.sizeof)
    mii.fMask = MIIM_ID or MIIM_TYPE or MIIM_DATA or MIIM_SUBMENU or MIIM_STATE
    mii.fType = MF_OWNERDRAW
    mii.dwTypeData = this.mText[0].unsafeAddr
    mii.cch = cast[UINT](len(this.mText))
    mii.dwItemData = cast[ULONG_PTR](cast[PVOID](this))
    mii.wID = cast[UINT](this.mId)
    mii.hSubMenu = if this.mPopup : this.mHmenu else: nil
    InsertMenuItemW(parentHmenu, UINT(this.mIndex), 1, mii.unsafeAddr)
    this.mIsCreated = true

# proc findMenuItem(this: MenuItem, txt: Wstring): MenuItem =
#     if this.mText == txt:
#         return this
#     else:
#         if len(this.mMenus) > 0:
#             for menu in this.mMenus: findMenuItem(menu, txt)





proc create(this: MenuItem) =
    case this.mType
    of mtBaseMenu, mtPopup:
        if len(this.mMenus) > 0:
            for key, menu in this.mMenus: menu.create()

        this.insertMenuInternal(this.mParentHmenu)

    of mtMenuItem:
        this.insertMenuInternal(this.mParentHmenu)
    of mtSeparator:
        AppendMenuW(this.mParentHmenu, MF_SEPARATOR, 0, nil)
    else: discard


proc addMenu*(this: MenuBar, txt: ref Wstring, txtColor: uint = 0x000000): MenuItem  =

    result = newMenuItem(txt, mtBaseMenu, this.mHmenubar, this.mMenuCount)
    result.mFormHwnd = this.mParent.mHandle
    result.mFgColor = newColor(txtColor)
    result.mFormMenu = true
    this.mMenuCount += 1
    this.mMenus[result.mId] = result
    this.mParent.mMenuItemDict[result.mId] = result

proc addMenu*(this: MenuItem, txt: LPCWSTR, txtColor: uint = 0x000000, sm: bool = true) : MenuItem {.discardable.} =
    if this.mType == mtMenuItem:
        this.mHmenu = CreatePopupMenu()
        this.mPopup = true

    var rws = toWstring2(txt)
    result = newMenuItem(rws, mtMenuItem, this.mHmenu, this.mChildCount)
    result.mFgColor = newColor(txtColor)
    result.mFormHwnd = this.mFormHwnd
    result.mFormMenu = this.mFormMenu
    if this.mType != mtBaseMenu: this.mType = mtPopup
    this.mChildCount += 1
    this.mMenus[result.mId] = result
    if sm:
        var lpm = cast[LPARAM](cast[PVOID](result))
        if result.mFormMenu: SendMessageW(result.mFormHwnd, MM_MENU_ADDED, WPARAM(result.mId), lpm)

proc glfAddMenuItem1(this: Form, parentMenu: LPCWSTR, menuTxt: LPCWSTR, fgColor: uint,
                        menuid: ref int32): MenuItem {.exportc:"glfAddMenuItem1", stdcall, dynlib.} =
    if len(this.mMenuItemDict) > 0:
        var pmenuTxt = toWstring(parentMenu)
        var menuText = toWstring(menuTxt)
        for menu in this.mMenuItemDict.mvalues:
            if menu.mText == pmenuTxt:
                result = menu.addMenu(menuText[0].addr, fgColor, false)
                this.mMenuItemDict[result.mId] = result
                menuid[] = result.mId
                break



proc glfAddMenuItem2(this: Form, parentMenuId: int32, menuTxt: LPCWSTR, fgColor: uint,
                        menuid: var int32): MenuItem {.exportc:"glfAddMenuItem2", stdcall, dynlib.} =
    if len(this.mMenuItemDict) > 0:
        var menuText = toWstring(menuTxt)
        var menu = this.mMenuItemDict.getOrDefault(parentMenuId)
        if menu != nil:
            result = menu.addMenu(menuText[0].addr, fgColor, false)
            this.mMenuItemDict[result.mId] = result
            menuid = result.mId




proc addSeparator*(this: MenuItem) =
    var mi = newMenuItem(nil, mtSeparator, this.mHmenu, this.mChildCount)
    this.mChildCount += 1
    this.mMenus[mi.mId] = mi

proc createMenuBarHandle(this: MenuBar) =
    this.mParent.mMenuDefBgBrush = newColor(0xe9ecef).makeHBRUSH()
    this.mParent.mMenuHotBgBrush = newColor(0x90e0ef).makeHBRUSH()
    this.mParent.mMenuFrameBrush = newColor(0x0077b6).makeHBRUSH()
    this.mParent.mMenuFont = this.mFont
    if len(this.mMenus) > 0:
        for key, menu in this.mMenus: menu.create()

    SetMenu(this.mParent.mHandle, this.mHmenubar)

proc getChildFromIndex(this: MenuItem, index: int32): MenuItem =
    for key, menu in this.mMenus:
        if menu.mIndex == index:
            return menu
    return nil

proc foreColor*(this : MenuItem): Color = this.mFgColor

proc `foreColor=`*(this: MenuItem, value: uint) =
    this.mFgColor = newColor(value)
    if this.mType == mtBaseMenu: InvalidateRect(this.mHmenu, nil, 0)

proc `foreColor=`*(this: MenuItem, value: Color) =
    this.mFgColor = value
    if this.mType == mtBaseMenu: InvalidateRect(this.mHmenu, nil, 0)


proc enabled*(this: MenuItem): bool = this.mIsEnabled

proc `enabled=`*(this: MenuItem, value: bool) =
    this.mIsEnabled = value
    if this.mType == mtBaseMenu: InvalidateRect(this.mHmenu, nil, 0)

proc font*(this: MenuItem): Font = this.mFont

proc `font=`*(this: MenuItem, value: Font) =
    this.mFont = value
    if this.mType == mtBaseMenu: InvalidateRect(this.mHmenu, nil, 0)






