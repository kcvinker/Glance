
# Event module - Created on 28-Mar-2023 12:47 AM
const
    TVN_FIRST = cast[UINT](0-400)
    TVN_SELCHANGINGW = TVN_FIRST-50
    TVN_SELCHANGEDW = TVN_FIRST-51
    TVN_ITEMEXPANDINGW = TVN_FIRST-54
    TVN_ITEMEXPANDEDW = TVN_FIRST-55
    TVN_DELETEITEMW = TVN_FIRST-58



proc newEventArgs(): EventArgs = new(result)

proc newPaintEventArgs(ps: LPPAINTSTRUCT) : PaintEventArgs =
    new(result)
    result.paintStruct = ps

proc getXFromLp(lp: LPARAM): int32 = cast[int32](LOWORD(lp))
proc getYFromLp(lp: LPARAM): int32 = cast[int32](HIWORD(lp))

proc newMouseEventArgs(msg: UINT, wp: WPARAM, lp: LPARAM): MouseEventArgs =
    new(result)
    let fwKeys = LOWORD(wp)
    result.mDelta = cast[int32](GET_WHEEL_DELTA_WPARAM(wp))
    case fwKeys   # IMPORTANT*********** Work here --> change 4 to 5, 8 to 9 etc
    of 5 : result.mShiftPressed = true
    of 9 : result.mCtrlPressed = true
    of 16 : result.mButton = mbMiddle
    of 32 : result.mButton = mbXButton1
    else: discard

    case msg
    of WM_LBUTTONDOWN, WM_LBUTTONUP: result.mButton = mbLeft
    of WM_RBUTTONDOWN, WM_RBUTTONUP: result.mButton = mbRight
    else: discard

    result.mx = getXFromLp(lp)
    result.my = getYFromLp(lp)


proc newKeyEventArgs(wp: WPARAM, isDown: bool, ctl: Control): KeyEventArgs =
    new(result)
    result.mKeyCode = cast[Keys](wp)
    result.mKeyValue = cast[int32](result.mKeyCode)

    case result.mKeyCode
    of keyShift:
        ctl.mKeyMod = if isDown: ctl.mKeyMod + 1 else: ctl.mKeyMod - 1
    of keyCtrl:
        ctl.mKeyMod = if isDown: ctl.mKeyMod + 2 else: ctl.mKeyMod - 2
    of keyAlt:
        ctl.mKeyMod = if isDown: ctl.mKeyMod + 4 else: ctl.mKeyMod - 4
    else: discard
    result.mShiftPressed = bool(ctl.mKeyMod and 1)
    result.mCtrlPressed = bool(ctl.mKeyMod and 2)
    result.mAltPressed = bool(ctl.mKeyMod and 4)



proc newKeyPressEventArgs(wp: WPARAM): KeyPressEventArgs =
    new(result)
    result.keyChar = cast[char](wp)

proc newSizeEventArgs(msg: UINT, lp: LPARAM): SizeEventArgs =
    new(result)
    if msg == WM_SIZING:
        result.mWinRect = cast[LPRECT](lp)
    else:
        result.mClientArea.width = cast[int32](LOWORD(lp))
        result.mClientArea.height = cast[int32](HIWORD(lp))

proc newDateTimeEventArgs(dtpStr: LPCWSTR): DateTimeEventArgs =
    new(result)
    result.mDateStr = wcharPtrToString(dtpStr)

proc newTreeEventArgs(ntv: LPNMTREEVIEWW): TreeEventArgs =
    new(result)
    if ntv.hdr.code == TVN_SELCHANGINGW or ntv.hdr.code == TVN_SELCHANGEDW:
        case ntv.action
        of 0 : result.mAction = tvaUnknown
        of 1 : result.mAction = tvaByMouse
        of 2 : result.mAction = tvaByKeyboard
        else: discard
        # echo "mAction in sel change " & $result.mAction
    elif ntv.hdr.code == TVN_ITEMEXPANDEDW or ntv.hdr.code == TVN_ITEMEXPANDINGW:
        case ntv.action
        of 0 : result.mAction = tvaUnknown
        of 1 : result.mAction = tvaCollapse
        of 2 : result.mAction = tvaExpand
        else: discard
        # echo "mAction in expand " & $result.mAction
    result.mNode = cast[TreeNode](cast[PVOID](ntv.itemNew.lParam))
    if ntv.itemOld.lParam > 0:
        result.mOldNode = cast[TreeNode](cast[PVOID](ntv.itemOld.lParam))

proc newTreeEventArgs(ntv: LPNMTVITEMCHANGE): TreeEventArgs =
    new(result)
    result.mNewState = ntv.uStateNew
    result.mOldState = ntv.uStateOld
    result.mNode = cast[TreeNode](cast[PVOID](ntv.lParam))

# Event properties
proc x*(this: MouseEventArgs): int32 = this.mx
proc y*(this: MouseEventArgs): int32 = this.my
proc delta*(this: MouseEventArgs): int32 = this.mDelta
proc shiftPressed*(this: MouseEventArgs): bool = this.mShiftPressed
proc ctrlPressed*(this: MouseEventArgs): bool = this.mCtrlPressed
proc mouseButton*(this: MouseEventArgs): MouseButtons = this.mButton






proc getMouseEventArgs(ea: MouseEventArgs, xp: var int32, yp: var int32, delta: var int32,
                        shiftP: var bool, ctrlP: var bool, mbtn: var int ) {.exportc:"getMouseEventArgs", stdcall, dynlib.} =
    xp = ea.mx
    yp = ea.my
    delta = ea.mDelta
    shiftP = ea.mShiftPressed
    ctrlP = ea.mCtrlPressed
    mbtn = cast[int](ea.mButton)
    # echo "Keys.high ", $(int(Keys.high))

proc getKeyEventArgs(kea: KeyEventArgs, bAlt: var byte, bCtrl: var byte, bShift: var byte,  kval: var int32,
                    kcod: var int32) {.exportc:"getKeyEventArgs", stdcall, dynlib.} =
    bAlt = byte(kea.mAltPressed)
    bCtrl = byte(kea.mCtrlPressed)
    bShift = byte(kea.mShiftPressed)
    kval = kea.mKeyValue
    kcod = int32(kea.mKeyCode)

proc getKeyPressEventArgs(kea: KeyPressEventArgs, kchar: var char) {.exportc:"getKeyPressEventArgs", stdcall, dynlib.} =
    kchar = kea.keyChar

proc getPaintEventArgs(pea: PaintEventArgs, rcleft, rctop, rcright,
                        rcbottom: var int32 ): HDC {.exportc:"getPaintEventArgs", stdcall, dynlib.} =
    result = pea.paintStruct.hdc
    rcleft = pea.paintStruct.rcPaint.left
    rctop = pea.paintStruct.rcPaint.top
    rcright = pea.paintStruct.rcPaint.right
    rcbottom = pea.paintStruct.rcPaint.bottom

proc getSizeEventArgs(sea: SizeEventArgs, rcleft, rctop, rcright,
                        rcbottom, wWidth, wHeight: var int32 ) {.exportc:"getSizeEventArgs", stdcall, dynlib.} =
    rcleft = sea.mWinRect.left
    rctop = sea.mWinRect.top
    rcright = sea.mWinRect.right
    rcbottom = sea.mWinRect.bottom
    wWidth = sea.mClientArea.width
    wHeight = sea.mClientArea.height

proc getDateTimeEventArgs(dea: DateTimeEventArgs, stYear, stMonth, stDay, stHr, stMin,
                            stSec, stMilli, stDoW: var WORD ): string {.exportc:"getDateTimeEventArgs", stdcall, dynlib.} =
    result = dea.mDateStr
    stYear = dea.mDateStruct.wYear
    stMonth = dea.mDateStruct.wMonth
    stDay = dea.mDateStruct.wDay
    stHr = dea.mDateStruct.wHour
    stMin = dea.mDateStruct.wMinute
    stSec = dea.mDateStruct.wSecond
    stMilli = dea.mDateStruct.wMilliseconds
    stDoW = dea.mDateStruct.wDayOfWeek

proc getTreeEventArgs(tea: TreeEventArgs, action: var int, nstate, ostate: var UINT,
                            nnode, onode: pointer ) {.exportc:"getTreeEventArgs", stdcall, dynlib.} =
    action = int(tea.mAction)
    ostate = tea.mOldState
    nstate = tea.mNewState
    cast[ref TreeNode](nnode)[] = tea.mNode
    cast[ref TreeNode](onode)[] = tea.mOldNode
