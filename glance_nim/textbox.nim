# textbox module Created on 04-Apr-2023 03:44 AM; Author kcvinker[Added to Glance on 04-Jun-2023 01:05]
# TextBox type
#   Constructor - newTextBox*(parent: Form, text: string, x, y: int32 = 10, w: int32 = 120, h: int32 = 27): TextBox
#   Functions
        # createHandle() - Create the handle of textBox

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

        # textAlign     TextAlignment - {taLeft, taCenter, taRight}
        # textCase      TextCase - {tcNormal, tcLowerCase, tcUpperCase}
        # textType      TextType - {ttNormal, ttNumberOnly, ttPasswordChar}
        # multiLine     bool
        # hideSelection bool
        # readOnly      bool
        # cueBanner     string

    # Events
    #     onMouseEnter*, onClick*, onMouseLeave*, onRightClick*, onDoubleClick*,
    #     onLostFocus*, onGotFocus*: EventHandler - proc(c: Control, e: EventArgs)

    #     onMouseWheel*, onMouseHover*, onMouseMove*, onMouseDown*, onMouseUp*
    #     onRightMouseDown*, onRightMouseUp*: MouseEventHandler - - proc(c: Control, e: MouseEventArgs)

    #     onTextChanged*: EventHandler

# Constants
const
    ECM_FIRST = 0x1500
    ES_AUTOHSCROLL = 128
    ES_MULTILINE = 4
    ES_WANTRETURN = 4096
    ES_NOHIDESEL = 256
    ES_READONLY = 0x800
    ES_LOWERCASE = 16
    ES_UPPERCASE = 8
    ES_PASSWORD = 32
    EM_SETCUEBANNER = ECM_FIRST + 1
    EN_CHANGE = 0x0300

var tbCount = 1
let TBSTYLE : DWORD = WS_CHILD or WS_VISIBLE or ES_LEFT or WS_TABSTOP or ES_AUTOHSCROLL or WS_MAXIMIZEBOX or WS_OVERLAPPED
let TBEXSTYLE: DWORD = WS_EX_LEFT or WS_EX_LTRREADING or WS_EX_CLIENTEDGE or WS_EX_NOPARENTNOTIFY

# Forward declaration
proc tbWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.}

# TextBox constructor 120, 27
proc newTextBox*(parent: Form, text: LPCWSTR, x, y, w, h: int32): TextBox {.exportc:"newTextBox", stdcall, dynlib.} =
    new(result)
    result.mKind = ctTextBox
    result.mClassName = "Edit"
    result.mName = "TextBox_" & $tbCount
    result.mParent = parent
    result.mXpos = x
    result.mYpos = y
    result.mWidth = w
    result.mHeight = h
    result.mText = toWstring(text)
    result.mFont = parent.mFont
    result.mBackColor = CLR_WHITE
    result.mForeColor = CLR_BLACK
    result.mStyle = TBSTYLE
    result.mExStyle = TBEXSTYLE
    result.mHasText = true
    result.mParent.controls.add(result)
    result.mCtlID = globalCtlID
    globalCtlID += 1
    tbCount += 1


proc setTBStyle(this: TextBox) =
    if this.mMultiLine: this.mStyle = this.mStyle or ES_MULTILINE or ES_WANTRETURN
    if not this.mHideSel: this.mStyle = this.mStyle or ES_NOHIDESEL
    if this.mReadOnly: this.mStyle = this.mStyle or ES_READONLY

    if this.mTextCase == tcLowerCase:
        this.mStyle = this.mStyle or ES_LOWERCASE
    elif this.mTextCase == tcUpperCase:
        this.mStyle = this.mStyle or ES_UPPERCASE

    if this.mTextType == ttNumberOnly:
        this.mStyle = this.mStyle or ES_NUMBER
    elif this.mTextType == ttPasswordChar:
        this.mStyle = this.mStyle or ES_PASSWORD

    if this.mTextAlign == taCenter:
        this.mStyle = this.mStyle or ES_CENTER
    elif this.mTextAlign == taRight:
        this.mStyle = this.mStyle or ES_RIGHT
    this.mBkBrush = CreateSolidBrush(this.mBackColor.cref)

# Create TextBox's hwnd
method createHandle*(this: TextBox) =
    this.setTBStyle()
    this.createHandleInternal()
    if this.mHandle != nil:
        this.setSubclass(tbWndProc)
        this.setFontInternal()
        if this.mCueBanner.len > 0: this.sendMsg(EM_SETCUEBANNER, 1, toWcharPtr(this.mCueBanner))

# Properties--------------------------------------------------------------------------

proc `textAlign=`*(this: TextBox, value: TextAlignment) = this.mTextAlign = value
proc textAlign*(this: TextBox): TextAlignment = this.mTextAlign

proc `textCase=`*(this: TextBox, value: TextCase) = this.mTextCase = value
proc textCase*(this: TextBox): TextCase = this.mTextCase

proc `textType=`*(this: TextBox, value: TextType) = this.mTextType = value
proc textType*(this: TextBox): TextType = this.mTextType

proc `cueBanner=`*(this: TextBox, value: LPCWSTR) = this.mCueBanner = toWstring(value)
proc cueBanner*(this: TextBox): Wstring = this.mCueBanner

proc `multiLine=`*(this: TextBox, value: bool) = this.mMultiLine = value
proc multiLine*(this: TextBox): bool = this.mMultiLine

proc `hideSelection=`*(this: TextBox, value: bool) = this.mHideSel = value
proc hideSelection*(this: TextBox): bool = this.mHideSel

proc `readOnly=`*(this: TextBox, value: bool) = this.mReadOnly = value
proc readOnly*(this: TextBox): bool = this.mReadOnly


proc setTextBoxProps(this: TextBox, prop: TextBoxProps, value: pointer) =
    case prop
    of tbTextAlign: this.textAlign = cast[TextAlignment](cast[ref int](value)[])
    of tbTextCase: this.textCase = cast[TextCase](cast[ref int](value)[])
    of tbTextType: this.textType = cast[TextType](cast[ref int](value)[])
    of tbMultiLine: this.multiLine = cast[bool](cast[ref int](value)[])
    of tbHideSelection: this.hideSelection = cast[bool](cast[ref int](value)[])
    of tbReadOnly: this.readOnly = cast[bool](cast[ref int](value)[])
    of tbCueBanner: this.cueBanner = cast[LPWCHAR](value)

proc getTextBoxProps(this: TextBox, prop: TextBoxProps, value: pointer) =
    case prop
    of tbTextAlign: cast[ref int32](value)[] = int32(this.textAlign)
    of tbTextCase: cast[ref int32](value)[] = int32(this.textCase)
    of tbTextType: cast[ref int32](value)[] = int32(this.textType)
    of tbMultiLine: cast[ref bool](value)[] = this.multiLine
    of tbHideSelection: cast[ref bool](value)[] = this.hideSelection
    of tbReadOnly: cast[ref bool](value)[] = this.readOnly
    of tbCueBanner: cast[ref LPWCHAR](value)[] = toWcharPtr(this.cueBanner)



proc tbWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.} =
    var this = cast[TextBox](refData)
    case msg
    of WM_DESTROY:
        this.destructor()
        RemoveWindowSubclass(hw, tbWndProc, scID)
    of WM_LBUTTONDOWN: this.leftButtonDownHandler(msg, wpm, lpm)
    of WM_LBUTTONUP: this.leftButtonUpHandler(msg, wpm, lpm)
    of WM_RBUTTONDOWN: this.rightButtonDownHandler(msg, wpm, lpm)
    of WM_RBUTTONUP: this.rightButtonUpHandler(msg, wpm, lpm)
    of WM_MOUSEMOVE: this.mouseMoveHandler(msg, wpm, lpm)
    of WM_MOUSELEAVE: this.mouseLeaveHandler()
    of WM_KEYDOWN: this.keyDownHandler(wpm)
    of WM_KEYUP: this.keyUpHandler(wpm)
    of WM_CHAR: this.keyPressHandler(wpm)
    of WM_CONTEXTMENU:
        if this.mContextMenu != nil: this.mContextMenu.showMenu(lpm)

    of WM_PAINT: return this.paintHandler(hw, msg, wpm, lpm)

    of MM_EDIT_COLOR:
        if this.mDrawMode > 0:
            let hdc = cast[HDC](wpm)
            if (this.mDrawMode and 1) == 1: SetTextColor(hdc, this.mForeColor.cref)
            if (this.mDrawMode and 2) == 2: SetBkColor(hdc, this.mBackColor.cref)
        return cast[LRESULT](this.mBkBrush)

    of WM_COMMAND:
        let ncode = HIWORD(wpm)
        if ncode == EN_CHANGE:
            if this.onTextChanged != nil: this.onTextChanged(this, newEventArgs())

    else: return DefSubclassProc(hw, msg, wpm, lpm)
    return DefSubclassProc(hw, msg, wpm, lpm)
