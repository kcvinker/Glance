# Controls module. Created on 27-Mar-2023 01:35 AM; Author kcvinker
## Control type - Base type for all other controls and Form.
#     Constructor - No constructor available. This is an astract type.
#     Functions - No public function in this type
#     Properties - Getter & Setter available
#       Name            Type
        # font          Font
        # text          string
        # width         int32
        # height        int32
        # xpos          int32
        # ypos          int32
        # backColor     Color
        # foreColor     Color

    # Events
    #     onMouseEnter*, onClick*, onMouseLeave*, onRightClick*, onDoubleClick*,
    #     onLostFocus*, onGotFocus*: EventHandler - proc(c: Control, e: EventArgs)

    #     onMouseWheel*, onMouseHover*, onMouseMove*, onMouseDown*, onMouseUp*
    #     onRightMouseDown*, onRightMouseUp*: MouseEventHandler - - proc(c: Control, e: MouseEventArgs)

    #     onKeyDown*, onKeyUp*: KeyEventHandler - proc(c: Control, e: KeyEventArgs)
    #     onKeyPress*: KeyPressEventHandler - proc(c: Control, e: KeyPressEventArgs)


const
    BCM_FIRST = 0x1600
    BCM_GETIDEALSIZE = BCM_FIRST+0x1

    ES_NUMBER = 0x2000
    ES_LEFT = 0
    ES_CENTER = 1
    ES_RIGHT = 2
    EN_UPDATE = 0x0400
    EM_SETSEL = 0x00B1

# Package variables==================================================
var globalCtlID : int32 = 100
var globalSubClassID : UINT_PTR = 1000
method createHandle(c: Control) {.base.} = discard
# Control class's methods====================================================
proc setSubclass(this: Control, ctlWndProc: SUBCLASSPROC) =
    SetWindowSubclass(this.mHandle, ctlWndProc, globalSubClassID, cast[DWORD_PTR](cast[PVOID](this)))
    globalSubClassID += 1

proc destructor(this: Control) =
    if this.mBkBrush != nil: DeleteObject(this.mBkBrush)
    if this.mContextMenu != nil: DestroyWindow(this.mContextMenu.mDummyHwnd)
    # if this.mFont.handle != nil: DeleteObject(this.mFont.handle)

proc sendMsg(this: Control, msg: UINT, wpm: auto, lpm: auto): LRESULT {.discardable, inline.} =
    return SendMessageW(this.mHandle, msg, cast[WPARAM](wpm), cast[LPARAM](lpm))

proc setFontInternal(this: Control) =
    if this.mIsCreated:
        if this.mFont.handle == nil: this.mFont.createHandle(this.mHandle)
        this.sendMsg(WM_SETFONT, this.mFont.handle, 1)

proc checkRedraw(this: Control) =
    if this.mIsCreated: InvalidateRect(this.mHandle, nil, 0)

proc getControlText(hw: HWND): string =
    let count = GetWindowTextLengthW(hw)
    var buffer: seq[WCHAR] = newSeq[WCHAR](count + 1)
    GetWindowTextW(hw, buffer[0].unsafeAddr, count + 1)
    result = wstringToString(buffer)

# Control class's properties==========================================
proc handle*(this: Control): HWND = this.mHandle

proc `font=`*(this: Control, value: Font) {.inline.} =
    this.mFont = value
    if this.mIsCreated: this.setFontInternal()

proc font*(this: Control): Font {.inline.} = return this.mFont

proc `text=`*(this: Control, value: LPCWSTR) {.inline.} =
    this.mText = toWstring(value)
    if this.mIsCreated: discard

proc text*(this: Control): wstring {.inline.} = return this.mText

proc `width=`*(this: Control, value: int32) {.inline.} =
    this.mWidth = value
    if this.mIsCreated: discard

proc width*(this: Control): int32 {.inline.} = return this.mWidth

proc `height=`*(this: Control, value: int32) {.inline.} =
    this.mHeight = value
    if this.mIsCreated: discard

proc height*(this: Control): int32 {.inline.} = return this.mHeight

proc `xpos=`*(this: Control, value: int32) {.inline.} =
    this.mXpos = value
    if this.mIsCreated: discard

proc xpos*(this: Control): int32 {.inline.} = return this.mXpos

proc `ypos=`*(this: Control, value: int32) {.inline.} =
    this.mYpos = value
    if this.mIsCreated: discard

proc ypos*(this: Control): int32 {.inline.} = return this.mYpos

proc setBackColor(this: Button, clr: uint) # Forward declaration.

proc `backColor=`*(this: Control, value: uint) =
    if this.mKind == ctButton:
        cast[Button](this).setBackColor(value)
    else:
        this.mBackColor = newColor(value)
        if (this.mDrawMode and 2) != 2 : this.mDrawMode += 2
        if this.mIsCreated:
            this.mBkBrush = this.mBackColor.makeHBRUSH
            InvalidateRect(this.mHandle, nil, 0)

proc `backColor=`*(this: Control, value: Color) {.inline.} =
    this.mBackColor = value
    if (this.mDrawMode and 2) != 2 : this.mDrawMode += 2
    if this.mIsCreated:
        this.mBkBrush = this.mBackColor.makeHBRUSH
        InvalidateRect(this.mHandle, nil, 0)

proc backColor*(this: Control): uint {.inline.} = return this.mBackColor.value

proc `foreColor=`*(this: Control, value: uint) {.inline.} =
    this.mForeColor = newColor(value)
    if (this.mDrawMode and 1) != 1 : this.mDrawMode += 1
    if this.mIsCreated: InvalidateRect(this.mHandle, nil, 0)

proc foreColor*(this: Control): uint {.inline.} = return this.mForeColor.value






# Event handlers for Control======================================================
proc leftButtonDownHandler(this: Control, msg: UINT, wp: WPARAM, lp: LPARAM) =
    if this.onMouseDown != nil: this.onMouseDown(this, newMouseEventArgs(msg, wp, lp))



proc leftButtonUpHandler(this: Control, msg: UINT, wp: WPARAM, lp: LPARAM) =
    if this.onMouseUp != nil: this.onMouseUp(this, newMouseEventArgs(msg, wp, lp))
    if this.onClick != nil: this.onClick(this, newEventArgs())



proc rightButtonDownHandler(this: Control, msg: UINT, wp: WPARAM, lp: LPARAM) =
    if this.onRightMouseDown != nil: this.onRightMouseDown(this, newMouseEventArgs(msg, wp, lp))


proc rightButtonUpHandler(this: Control, msg: UINT, wp: WPARAM, lp: LPARAM) =
    if this.onRightMouseUp != nil: this.onRightMouseUp(this, newMouseEventArgs(msg, wp, lp))
    if this.onRightClick != nil: this.onRightClick(this, newEventArgs())


proc mouseWheelHandler(this: Control, msg: UINT, wp: WPARAM, lp: LPARAM) =
    if this.onMouseWheel != nil: this.onMouseWheel(this, newMouseEventArgs(msg, wp, lp))

proc mouseMoveHandler(this: Control, msg: UINT, wp: WPARAM, lp: LPARAM) =
    if this.mIsMouseEntered:
        if this.onMouseMove != nil: this.onMouseMove(this, newMouseEventArgs(msg, wp, lp))
    else:
        this.mIsMouseEntered = true
        if this.onMouseEnter != nil: this.onMouseEnter(this, newEventArgs())

proc mouseLeaveHandler(this: Control) =
    this.mIsMouseEntered = false
    if this.onMouseLeave != nil: this.onMouseLeave(this, newEventArgs())

proc keyDownHandler(this: Control, wp: WPARAM) =
    if this.onKeyDown != nil: this.onKeyDown(this, newKeyEventArgs(wp, true, this))

proc keyUpHandler(this: Control, wp: WPARAM) =
    if this.onKeyUp != nil: this.onKeyUp(this, newKeyEventArgs(wp, false, this))

proc keyPressHandler(this: Control, wp: WPARAM) =
    if this.onKeyPress != nil: this.onKeyPress(this, newKeyPressEventArgs(wp))

proc paintHandler(this: Control, hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM) : LRESULT =
    if this.onPaint != nil:
        var ps : PAINTSTRUCT
        BeginPaint(hw, ps.unsafeAddr)
        this.onPaint(this, newPaintEventArgs(ps.unsafeAddr))
        EndPaint(hw, ps.unsafeAddr)
        return 1
    return DefSubclassProc(hw, msg, wpm, lpm)

# Package level functions====================================================
proc createHandleInternal(this: Control, specialCtl: bool = false) =
    # if not specialCtl:
    #     this.mCtlID = globalCtlID
    #     globalCtlID += 1
    var txtPtr: LPCWSTR = if this.mHasText: this.mText[0].unsafeAddr else: nil
    this.mHandle = CreateWindowExW( this.mExStyle,
                                    toWcharPtr(this.mClassName),
                                    txtPtr,
                                    this.mStyle, this.mXpos, this.mYpos,
                                    this.mWidth, this.mHeight,
                                    this.mParent.mHandle, cast[HMENU](this.mCtlID),
                                    this.mParent.hInstance, nil)
    if this.mHandle != nil:
        this.mIsCreated = true
         # We keep ourselfs in our parent's hand

# Only used CheckBox & RadioButton
# proc setIdealSize(this: Control) =
#     var ss = SIZE(cx: 0, cy: 0)
#     this.sendMsg(BCM_GETIDEALSIZE, 0, ss.unsafeAddr)
#     this.mWidth = ss.cx
#     this.mHeight = ss.cy
#     echo "ss size ", $ss.cx
#     MoveWindow(this.mHandle, this.mXpos, this.mYpos, ss.cx, ss.cy, 1)

proc setSizeWithText(this: Control) =
    var hdc : HDC = GetDC(this.mHandle)
    var size = SIZE(cx: 0, cy: 0)
    SelectObject(hdc, this.mFont.handle)
    GetTextExtentPoint32(hdc, this.mText[0].unsafeAddr, int32(this.mText.len), size.unsafeAddr)
    ReleaseDC(this.mHandle, hdc)
    this.mWidth = size.cx + 10
    this.mHeight = size.cy
    MoveWindow(this.mHandle, this.mXpos, this.mYpos, this.mWidth, this.mHeight, 1)

proc getControlName(this: Control) : LPCWSTR =
    case this.mKind
    of ctForm:
        result = toWcharPtr((cast[Form](this)).mName)
    else: discard


proc getCtrlHwnd(this: Control) : HWND {.exportc:"getCtrlHwnd", stdcall, dynlib.} = this.mHandle

proc setCtrlEvents(this: Control, evt: ControlEvents, funcPtr: EventHandler) =
    case evt
    of ceClick: this.onClick = funcPtr
    of ceDoubleClick: this.onDoubleClick = funcPtr
    of ceGotFocus: this.onGotFocus = funcPtr
    of ceLostFocus: this.onLostFocus = funcPtr
    of ceKeyDown: this.onKeyDown = cast[KeyEventHandler](funcPtr)
    of ceKeyPress: this.onKeyPress = cast[KeyPressEventHandler](funcPtr)
    of ceKeyUp: this.onKeyUp = cast[KeyEventHandler](funcPtr)
    of ceMouseDown: this.onMouseDown = cast[MouseEventHandler](funcPtr)
    of ceMouseEnter: this.onMouseEnter = funcPtr
    of ceMouseHover: this.onMouseHover = cast[MouseEventHandler](funcPtr)
    of ceMouseLeave: this.onMouseLeave = funcPtr
    of ceMouseMove: this.onMouseMove = cast[MouseEventHandler](funcPtr)
    of ceMouseUp: this.onMouseUp = cast[MouseEventHandler](funcPtr)
    of ceMouseWheel: this.onMouseWheel = cast[MouseEventHandler](funcPtr)
    of ceRightClick: this.onRightClick = funcPtr
    of ceRightMouseDown: this.onRightMouseDown = cast[MouseEventHandler](funcPtr)
    of ceRightMouseUp: this.onRightMouseUp = cast[MouseEventHandler](funcPtr)
    of cePaint: this.onPaint = cast[PaintEventHandler](funcPtr)
    of ceCmMenuShown: this.mContextMenu.onMenuShown = cast[ContextMenuEventHandler](funcPtr)
    of ceCmMenuClose: this.mContextMenu.onMenuClose = cast[ContextMenuEventHandler](funcPtr)

proc setCtrlProps(this: Control, prop: ControlProps, value: pointer) =
    case prop
    of cpText: this.text = cast[LPWCHAR](value)
    of cpBackColor: this.backColor = cast[ref uint](value)[]

    of cpForeColor: this.foreColor = cast[ref uint](value)[]
    # of cpContextMenu:
    of cpWidth: this.width = cast[ref int32](value)[]
    of cpHeight: this.height = cast[ref int32](value)[]
    of cpXpos: this.xpos = cast[ref int32](value)[]
    of cpYpos: this.ypos = cast[ref int32](value)[]
    of cpFont: this.font = cast[ref Font](value)[]
    else: discard

proc getCtrlProps(this: Control, prop: ControlProps, value: pointer) =
    case prop
    of cpKind: cast[ref int32](value)[] = int32(this.mKind)
    of cpWidth: cast[ref int32](value)[] = this.mWidth
    of cpHeight: cast[ref int32](value)[] = this.height
    of cpXpos: cast[ref int32](value)[] = this.xpos
    of cpYpos: cast[ref int32](value)[] = this.ypos
    of cpCtlID: cast[ref int32](value)[] = this.mCtlID
    of cpBackColor: cast[ref uint](value)[] = this.backColor
    of cpForeColor: cast[ref uint](value)[] = this.foreColor
    of cpText: cast[ref LPWCHAR](value)[] = toWcharPtr(this.text)
    of cpName: cast[ref LPWCHAR](value)[] = toWcharPtr(this.mName)
    of cpHandle: cast[ref HWND](value)[] = this.mHandle
    of cpFont: cast[ref Font](value)[] = this.mFont
    # of cpFont:
    else: discard





# Here we are including contextmenu module. Because, contextmenu should be available for all controls.
include contextmenu

# proc setContextMenuInternal(this: Control)

proc `contextMenu=`*(this: Control, value: ContextMenu) =
    this.mContextMenu = value

proc setContextMenu*(parent: Control, menuNames: LPCWSTR = nil) : ContextMenu {.exportc:"ctrlSetContextMenu", stdcall, dynlib.} =
    result = newContextMenu(parent, menuNames)
    parent.mContextMenu = result




