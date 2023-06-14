
; Glance GUI library - Autoit wrapper functions.

#include <Array.au3>
Global $hDll = 0
Local $gcList[1] = ["dummy"]
Local $fnPtrList[0]

func glf_Start()
	$hDll = DllOpen("glance.dll")
	OnAutoItExitRegister("OnScriptExit")
	; ConsoleWrite("dll status " & $hDll & @CRLF)
EndFunc

Global const $MOUSEBTN_NONE = 0
Global const $MOUSEBTN_LEFT = 1048576
Global const $MOUSEBTN_RIGHT = 2097152
Global const $MOUSEBTN_MIDDLE = 4194304
Global const $MOUSEBTN_XBTN1 = 8388608
Global const $MOUSEBTN_XBTN2 = 16777216

local Enum $fullParams = 1, $posAndSize
Global Enum Step 100 $fwLight = 300, $fwNormal, $fwMedium, $fwSemiBold, $fwBold, $fwExtraBold, $fwUltraBold

Global Enum $ctForm = 1, $ctButton, $ctCalendar, $ctCheckBox, $ctComboBox, $ctDateTimePicker, $ctGroupBox, $ctLabel, _
	   $ctListBox, $ctListView, $ctNumberPicker, $ctProgressBar, $ctRadioButton, $ctTextBox, $ctTrackBar, $ctTreeView

Local Enum $mnuMainMenu = 1, $mnuCMenu

Global Enum $maBaseMenu = 1, $maSubMenu, $maSeparator

; region Prop & Event map
func setEventsAndPropsValues(Byref $map)
	; All controls are inherited from Contro class. So it can use control props.
	; Menu is a control. So use menu props for them.
	if $map.type >=$ctForm and $map.type <= $ctTreeView Then
		$map.kind = 1 ; type: int, readonly
		$map.width = 2 ; type: int
		$map.height = 3 ; type: int
		$map.xpos = 4 ; type: int
		$map.ypos = 5 ; type: int
		$map.ctlID = 6 ; type: int
		$map.backColor = 7 ; type: uint
		$map.foreColor = 8 ; type: uint
		$map.text = 9 ; type: wstr
		$map.name = 10 ; type: str, readonly
		$map.handle = 11 ; type: hwnd, readonly
		$map.contextMenu = 12 ; type: ptr
		$map.font = 13 ; type: ptr
		$map.parent = 14 ; type: ptr, readonly

		; Badic function type for an event is EventHandler. The signature for it is "func(Sender, EventArgs)".
		; Sender is the control or component which sends the event. EventArgs is the extra arguments related to that event.
		; All other function types are commented out to the right side of their event names.
		; Signature for them are...
			; 1. KeyEventHandler = func(Sender, KeyEventArgs)
			; 2. KeyPressEventHandler = func(Sender, KeyPressEventArgs)
			; 3. MouseEventHandler = func(Sender, MouseEventArgs)
			; 4. PaintEventHandler = func(Sender, PaintEventArgs)
			; 5. SizeEventHandler = func(Sender, SizeEventArgs)
			; 6. TreeEventHandler = func(Sender, TreeEventArgs)
			; 7. MenuEventHandler = func(menu, EventArgs)


		$map.onClick = 1
		$map.onDoubleClick = 2
		$map.onGotFocus = 3
		$map.onLostFocus = 4
		$map.onKeyDown = 5 ; KeyEventHandler
		$map.onKeyPress = 6 ; KeyPressEventHandler
		$map.onKeyUp = 7 ; KeyEventHandler
		$map.onMouseDown = 8 ; MouseEventHandler
		$map.onMouseEnter = 9
		$map.onMouseHover = 10
		$map.onMouseLeave = 11
		$map.onMouseMove = 12 ; MouseEventHandler
		$map.onMouseUp = 13 ; MouseEventHandler
		$map.onMouseWheel = 14 ; MouseEventHandler
		$map.onRightClick = 15
		$map.onRightMouseDown = 16 ; MouseEventHandler
		$map.onRightMouseUp = 17 ; MouseEventHandler
		$map.onPaint = 18 ; PaintEventHandler
		$map.onCmenuShown = 19
		$map.onCmenuClose = 20
	EndIf

	Switch $map.type
		case $ctForm
			$map.startPos = 15 ; type: int
			$map.formState = 16 ; type: int
			$map.formStyle = 17 ; type: int
			$map.topMost = 18 ; type: bool
			$map.maximizeBox = 19 ; type: bool
			$map.minimizeBox = 20 ; type: bool

			$map.onLoad = 21
			$map.onMaximize = 22
			$map.onMinimize = 23
			$map.onRestore = 24
			$map.onClosing = 25
			$map.onActivate = 26
			$map.onDeActivate = 27
			$map.onMoving = 28
			$map.onMoved = 29
			$map.onSizing = 30 ; SizeEventHandler
			$map.onSized = 31 ; SizeEventHandler
		case $ctCalendar
			$map.value = 21 ; type: ptr
			$map.viewMode = 22 ; type: int
			$map.showWeekNumber = 23 ; type: bool
			$map.noTodayCircle = 24 ; type: bool
			$map.noToday = 25 ; type: bool
			$map.noTrailingDates = 26 ; type: bool
			$map.shortDateNames = 27 ; type: bool

			$map.onSelectionCommitted = 32
			$map.onValueChanged = 33
			$map.onViewChanged = 34
		case $ctCheckBox
			$map.checked = 28 ; type: bool
			$map.onCheckedChanged = 35
		case $ctComboBox
			$map.hasInput = 29 ; type: bool
			$map.selectedIndex = 30 ; type: int
			$map.selectedItem = 31 ; type: wstr

			$map.onSelectionChanged = 36
			$map.onTextChanged = 37
			$map.onTextUpdated = 38
			$map.onListOpened = 39
			$map.onListClosed = 40
			$map.onSelectionCommitted = 41
			$map.onSelectionCancelled = 42
		case $ctDateTimePicker
			$map.formatString = 32 ; type: wstr
			$map.value = 33 ; type: ptr
			$map.format = 34 ; type: int
			$map.rightAlign = 35 ; type: bool
			$map.noToday = 36 ; type: bool
			$map.showUpdown = 37 ; type: bool
			$map.showWeekNumber = 38 ; type: bool
			$map.noTodayCircle = 39  ; type: bool
			$map.noTrailingDates = 40 ; type: bool
			$map.shortDateNames = 41 ; type: bool
			$map.fourDigitYear = 42 ; type: bool

			$map.onValueChanged = 43
			$map.onCalendarOpened = 44
			$map.onCalendarClosed = 45
			$map.onTextChanged = 46
		case $ctLabel
			$map.autoSize = 43 ; type: bool
			$map.multiLine = 44 ; type: bool
			$map.textAlign = 45 ; type: int
			$map.borderStyle = 46 ; type: int

			$map.onSelectionChanged = 47
			$map.onSelectionCancelled = 48
		case $ctListBox
			$map.hotIndex = 47 ; type: int
			$map.selectedIndex = 48 ; type: int
			$map.horizontalScroll = 49 ; type: bool
			$map.verticalScroll = 50 ; type: bool
			$map.multiSelection = 51 ; type: bool
			$map.hotItem = 52 ; type: wstr
			$map.selectedItem = 53 ; type: wstr

			$map.onCheckedChanged = 49
			$map.onSelectionChanged = 50
			$map.onItemDoubleClicked = 51
			$map.onItemClicked = 52
			$map.onItemHover = 53
		case $ctListView
			$map.selectedIndex = 54 ; type: int
			$map.selectedSubIndex = 55 ; type: int
			$map.headerHeight = 56 ; type: int
			$map.editLabel = 57 ; type: bool
			$map.hideSelection = 58 ; type: bool
			$map.multiSelection = 59 ; type: bool
			$map.hasCheckBox = 60 ; type: bool
			$map.fullRowSelection = 61 ; type: bool
			$map.showGrid = 62 ; type: bool
			$map.oneClickActivate = 63 ; type: bool
			$map.hotTrackSelection = 64 ; type: bool
			$map.headerClickable = 65 ; type: bool
			$map.checked = 66 ; type: bool
			$map.checkBoxLast = 67 ; type: bool
			$map.viewStyle = 68 ; type: int
			$map.headerBackColor = 69 ; type: uint
			$map.headerForeColor = 70 ; type: uint
			$map.selectedItem = 71 ; type: wstr
		case $ctNumberPicker
			$map.onValueChanged = 54

			$map.value         = 72 ; type: float
			$map.stepp         = 73 ; type: float
			$map.minRange      = 74 ; type: float
			$map.maxRange      = 75 ; type: float
			$map.buttonLeft    = 76 ; type: bool
			$map.autoRotate    = 77 ; type: bool
			$map.hideCaret     = 78 ; type: bool
			$map.textAlign     = 79 ; type: int
			$map.decimalDigits = 80 ; type: int
		case $ctProgressBar
			$map.onProgressChanged = 55

			$map.value = 81 ;type: int
			$map.stepp = 82 ;type: int
			$map.marqueeSpeed = 83 ;type: int
			$map.style = 84 ;type: int
			$map.state = 85 ;type: int
			$map.showPercentage = 86 ;type: bool
		case $ctRadioButton
		    $map.onCheckedChanged = 56
		    $map.checked = 87 ; type: bool
		case $ctTextBox
			$map.onTextChanged = 57

			$map.textAlign = 88 ; type: int
			$map.textCase = 89 ; type: int
			$map.textType = 90 ; type: int
			$map.multiLine = 91 ; type: bool
			$map.hideSelection = 92 ; type: bool
			$map.readOnly = 93 ; type: bool
			$map.cueBanner = 94 ; type: wstr
		case $ctTrackBar
			$map.onValueChanged = 58
			$map.onDragging = 59
			$map.onDragged = 60

			$map.ticColor = 95 ; type: int
			$map.channelColor = 96 ; type: uint
			$map.selectionColor = 97 ; type: uint
			$map.channelStyle = 98 ; type: int
			$map.trackChange = 99 ; type: int
			$map.vertical = 100 ; type: bool
			$map.reversed = 101 ; type: bool
			$map.noTics = 102 ; type: bool
			$map.showSelRange = 103 ; type: bool
			$map.toolTipp = 104 ; type: bool
			$map.customDraw = 105 ; type: bool
			$map.freeMove = 106 ; type: bool
			$map.noThumb = 107 ; type: bool
			$map.ticPosition = 108 ; type: int
			$map.ticWidth = 109 ; type: int
			$map.minRange = 110 ; type: float
			$map.maxRange = 111 ; type: float
			$map.frequency = 112 ; type: float
			$map.pageSize = 113 ; type: int
			$map.lineSize = 114 ; type: int
			$map.ticLength = 115 ; type: int
			$map.value = 116 ; type: int
		case $ctTreeView
			$map.onBeginEdit = 61
			$map.onEndEdit = 62
			$map.onNodeDeleted = 63
			$map.onItemDoubleClick = 64
			$map.onBeforeChecked = 65 ; TreeEventHandler
			$map.onAfterChecked = 66 ; TreeEventHandler
			$map.onBeforeSelected = 67 ; TreeEventHandler
			$map.onAfterSelected = 68 ; TreeEventHandler
			$map.onBeforeExpanded = 69 ; TreeEventHandler
			$map.onAfterExpanded = 70 ; TreeEventHandler
			$map.onBeforeCollapsed = 71 ; TreeEventHandler
			$map.onAfterCollapsed = 72 ; TreeEventHandler

			$map.noLine = 117 ; type: bool
			$map.noButton = 118 ; type: bool
			$map.hasCheckBox = 119 ; type: bool
			$map.fullRowSelect = 120 ; type: bool
			$map.isEditable = 121 ; type: bool
			$map.showSelection = 122 ; type: bool
			$map.hotTrack = 123 ; type: bool
			$map.nodeCount = 124 ; type: int
			$map.uniqNodeID = 125 ; type: int, readonly
			$map.lineColor = 126 ; type: uint
			$map.selectedNode = 127 ; type: ptr
	EndSwitch
EndFunc

Func setMenuEventsAndPropsValues(ByRef $map, $type)
	$map.onMenuClick = 73 ; MenuEventHandler
	$map.onMenuPopup = 74 ; MenuEventHandler
	$map.onMenuCollapse = 75 ; MenuEventHandler
	$map.onMenuFocus = 76 ; MenuEventHandler

	if $type = $mnuCMenu Then
		$map.onContextMenuShown = 77
		$map.onContextMenuClose = 78

		$map.contextMenuWidth = 128 ; type: int
		$map.contextMenuHeight = 129 ; type: int
		$map.contextMenuFont = 130 ; type: ptr
		$map.contextMenuParent = 131 ; type: ptr
		$map.contextMenuHmenu = 132 ; type: HMENU
	Else
		$map.menuBarHmenu = 133 ; type: HMENU
		$map.menuBarFont = 134 ; type: ptr
		$map.menuBarParent = 135 ; type: ptr
		$map.menuBarMenuCount = 136 ; type: int
	EndIf
	$map.menuChildCount = 137 ; type: int
	$map.menuIndex = 138 ; type: int
	$map.menuType = 139 ; type: int
	$map.menuBackColor = 140 ; type: uint
	$map.menuForeColor = 141 ; type: uint
	$map.menuFont = 142 ; type: ptr
	$map.menuHmenu = 143 ; type: HMENU
	$map.menuText = 144 ; type: wstr

EndFunc

; endregion x

Func print($msg, $value = 0)
	ConsoleWrite($msg & " : " & $value & @CRLF)
EndFunc

; Helper function for each new controls

Func glf_GetMouseEventArgs($mea)
	Local $res[]
	Local $x, $y, $delta, $shift, $ctrl, $mbtn
	Local $d = DllCall($hDll, "none", "getMouseEventArgs", "ptr", $mea, _
			"int*", $x, "int*", $y, "int*", $delta, "int*", $shift, "int*", $ctrl, "int*", $mbtn)
	if @error Then
		$res.error = @error
		ConsoleWrite("getMouseEventArgs Error" & @CRLF)
	Else
		$res.x = $d[2]
		$res.y = $d[3]
		$res.delta = $d[4]
		$res.isShiftPressed = $d[5]
		$res.isCtrlPressed = $d[6]
		$res.mouseButton = $d[7]
	EndIf
	return $res
EndFunc

Func glf_GetKeyEventArgs($kea)
	Local $res[]
	Local $bAlt, $bCtrl, $bShift, $kval, $cod
	Local $d = DllCall($hDll, "none", "getKeyEventArgs", "ptr", $kea, "int*", $bAlt, _
			"int*", $bCtrl, "int*", $bShift, "int*", $kval, "int*", $cod)
	if @error Then
		$res.error = @error
		ConsoleWrite("getKeyEventArgs Error" & @CRLF)
	Else
		$res.isAltPressed = $d[2]
		$res.isCtrlPressed = $d[3]
		$res.isShiftPressed = $d[4]
		$res.keyValue = $d[5]
		$res.keyCode = $d[6]
	EndIf
	return $res
EndFunc

Func glf_GetKeyPressEventArgs($kea)
	Local $res[]
	Local $kchar
	Local $d = DllCall($hDll, "none", "getKeyPressEventArgs", "ptr", $kea, "char*", $kchar)
	if @error Then
		$res.error = @error
		ConsoleWrite("getPressKeyEventArgs Error" & @CRLF)
	Else
		$res.keyChar = $d[2]
	EndIf
	return $res
EndFunc

Func glf_GetPaintEventArgs($pea)
	Local $l, $t, $r, $b
	Local $map[]
	Local $res = DllCall($hDll, "HDC", "getPaintEventArgs", "ptr", $pea, "int*", $l, "int*", $t, "int*", $r, "int*", $b)
	if @error Then
		$map.error = @error
		Return $map
	Else
		$map.hdc = $res[0]
		$map.rcLeft = $res[2]
		$map.rcTop = $res[3]
		$map.rcRight = $res[4]
		$map.rcBottom = $res[5]
	EndIf
	Return $map
EndFunc

Func glf_GetSizeEventArgs($sea)
	Local $l, $t, $r, $b, $w, $h
	Local $map[]
	Local $res = DllCall($hDll, "none", "getSizeEventArgs", "ptr", $sea, _
						"int*", $l, "int*", $t, "int*", $r, "int*", $b, "int*", $w, "int*", $h)
	if @error Then
		$map.error = @error
		Return $map
	Else
		$map.rcLeft = $res[2]
		$map.rcTop = $res[3]
		$map.rcRight = $res[4]
		$map.rcBottom = $res[5]
		$map.width = $res[6]
		$map.height = $res[7]
	EndIf
	Return $map
EndFunc

Func glf_GetDateTimeEventArgs($dea)
	Local $yr, $mo, $d, $hr, $min, $sec, $mill, $dow
	Local $map[]
	Local $res = DllCall($hDll, "str", "getDateTimeEventArgs", "ptr", $dea, "word*", $yr, "word*", $mo, _
						"word*", $d, "word*", $hr, "word*", $min, "word*", $sec, "word*", $mill, "word*", $dow)
	if @error Then
		$map.error = @error
		Return $map
	Else
		$map.dateStr = $res[0]
		$map.wYear = $res[2]
		$map.wMonth = $res[3]
		$map.wDay = $res[4]
		$map.wHour = $res[5]
		$map.wMinute = $res[6]
		$map.wSecond = $res[7]
		$map.wMillisecond = $res[8]
		$map.wDayOfWeek = $res[9]
	EndIf
	Return $map
EndFunc

Func glf_GetTreeEventArgs($tea)
	Local $act, $nst, $ost, $nnod, $onod
	Local $map[]
	Local $res = DllCall($hDll, "none", "getgetTreeEventArgs", "ptr", $tea, "int*", $act, "uint*", $nst, _
						"uint*", $ost, "ptr*", $nnod, "ptr*", $onod)
	if @error Then
		$map.error = @error
		Return $map
	Else
		$map.action = $res[2]
		$map.newState = $res[3]
		$map.oldState = $res[4]
		$map.node = $res[5]
		$map.oldNode = $res[6]
	EndIf
	Return $map
EndFunc

Func glf_NewForm($title, $width = Default, $height = Default, $x = Default, $y = Default, $bCreate = Default)
	if $hDll = 0 Then glf_Start()
	if $width = Default Then $width = 500
	if $height = Default Then $height = 350
	if $x = Default Then $x = 0
	if $y = Default Then $y = 0
	if $bCreate = Default Then $bCreate = False
	Local $fm[] ; Form map
	$fm.type = $ctForm
	local $res = DllCall($hDll, "ptr", "getNewForm", "wstr", $title, "int", $width, "int", $height, "int", $x, "int", $y)
	if @error Then
		$fm.error = @error
	Else
		$fm.ptr = $res[0]
		$fm.type = $ctForm
		if $bCreate Then
			$res = DllCall($hDll, "hwnd", "frmCreateHwnd", "ptr", $fm.ptr)
			if @error Then
				$fm.error = @error
			Else
				$fm.HWnd = $res[0]
			EndIf
		Else
			$fm.hwnd = 0
		EndIf
	EndIf
	setEventsAndPropsValues($fm)
	Return $fm
EndFunc

Func glf_FormCreateHwnd(Byref $frmMap)
	local $res = DllCall($hDll, "hwnd", "frmCreateHwnd", "ptr", $frmMap.ptr)
	if @error Then
		$frmMap.error = @error
	Else
		$frmMap.hwnd = $res[0]
	EndIf
EndFunc

Func glf_FormShow($frmPtr)
	local $res = DllCall($hDll, "none", "frmDisplay", "ptr", $frmPtr)
EndFunc

Func glf_FormClose($frmMap)
	local $res = DllCall($hDll, "none", "frmClose", "ptr", $frmMap.ptr)
	if @error Then
		$frmMap.error = @error
	EndIf
EndFunc

; Create all control's hwnd and return the hwnds in an array is succeeded. If failed, returns 0
Func glf_CreateControls($formMap, $bReturnArray = False)
	Local $res = DllCall($hDll, "int", "createControlHwnds", "ptr", $formMap.ptr)
	if @error Then
		$formMap.error = @error
		return 0
	Else
		if $bReturnArray Then Global $arr[$res[0]]
		for $i = 0 to $res[0] - 1
			Local $r = DllCall($hDll, "hwnd", "getHwndSeqItem", "ptr", $formMap.ptr, "int", $i )
			if @error Then
				$formMap.error = @error
				return 0
			Else
				if $bReturnArray Then $arr[$i] = $r[0]
			EndIf
		Next
		DllCall($hDll, "none", "clearHwndSeq", "ptr", $formMap.ptr )
		if $bReturnArray Then Return $arr
	EndIf
	Return 0
EndFunc

Func glf_FormGradient($frmMap, $clr1, $clr2, $RTL = Default)
	if $RTL = Default Then $RTL = False
	local $res = DllCall($hDll, "none", "frmSetGradient", "ptr", $frmMap.ptr, _
							"uint", $clr1, "uint", $clr2, "BOOLEAN", $RTL)
	if @error Then $frmMap.error = @error
EndFunc

Func glf_GetHandle(Byref $ctlMap)
	local $res = DllCall($hDll, "hwnd", "getCtrlHwnd", "ptr", $ctlMap.ptr)
	if @error Then
		$ctlMap.error = @error
	Else
		$ctlMap.hwnd = $res[0]
	EndIf
EndFunc

func getPropertyType($index)
	Local $type = ""
	Switch $index
		case 1 to 5, 15 to 20, 22 to 30, 34 to 51, 54 to 68, 76 to 93, 98 to 125
			$type = "int*"

		case 6 to 8, 69, 70, 95 to 97, 126
			$type = "uint*"

		case 9, 10, 31, 52, 53, 71, 94
			$type = "wstr*"

		case 11
			$type = "hwnd*"

		case 12 to 14, 21, 33, 127
			$type = "ptr*"

		case 32
			$type = "str*"

		case 72 to 75
			$type = "double*"

	EndSwitch
	Return $type
EndFunc

Func glf_ControlGetProperty($controlMap, $propIndex)
	Local $valueHolder
	Local $type = getPropertyType($propIndex)
	local $res = DllCall($hDll, "none", "getProperty", "ptr", $controlMap.ptr, "int", $propIndex, $type, $valueHolder)
	if @error then $controlMap.error = @error
	return $res[3]
EndFunc

Func glf_ControlSetProperty($controlMap, $propIndex, $value)
	Local $valueHolder = $value
	; print("val in au3", $valueHolder)
	Local $type = getPropertyType($propIndex)
	local $res = DllCall($hDll, "none", "setProperty", "ptr", $controlMap.ptr, "int", $propIndex, $type, $valueHolder)
	if @error then $controlMap.error = @error
	; return $res[3]
EndFunc

Func glf_ControlAddHandler(ByRef $control, $event, $funcName)
	Local $pCallback = DllCallbackRegister($funcName, "none", "ptr;ptr")
	Local $pfuncPtr = DllCallbackGetPtr($pCallback)
	_ArrayAdd($fnPtrList, $pCallback)
	Local $ret = DllCall($hDll, "none", "setEventHandler", "ptr", $control.ptr, "int", $event, "ptr", $pfuncPtr)
	if @error then $control.error = @error
EndFunc

Func glf_ControlCreateHwnd(Byref $controlMap)
	local $res = DllCall($hDll, "hwnd", "createControlHwnd", "ptr", $controlMap.ptr)
	if @error Then
		$controlMap.error = @error
	Else
		$controlMap.hwnd = $res[0]
	EndIf
EndFunc

Func createCtrlInternal($parent, $nimFuncName, $paramType, $ctlType, $bCreate = Default, _
						$txt = Default, $x = Default, $y = Default, $w = Default, $h = Default)
	if $bCreate = Default Then $bCreate = False

	Local $ctlMap[]
	if $paramType = $fullParams Then
		Local $res = DllCall($hDll, "ptr", $nimFuncName, "ptr", $parent, "wstr", $txt, "int", $x, "int", $y, "int", $w, "int", $h)
	Else
		Local $res = DllCall($hDll, "ptr", $nimFuncName, "ptr", $parent, "int", $x, "int", $y, "int", $w, "int", $h)
	EndIf
	if @error Then
		$ctlMap.error = @error
	Else
		$ctlMap.ptr = $res[0]
		$ctlMap.type = $ctlType
		if $bCreate Then
			glf_ControlCreateHwnd($ctlMap)
		Else
			$ctlMap.hwnd = 0
		EndIf
	EndIf
	setEventsAndPropsValues($ctlMap)
	return $ctlMap
EndFunc


Func glf_NewButton($parentMap, $text = Default, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = Default)
	if $width = 0 Then $width = 100
	if $height = 0 Then $height = 35
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $text = Default Then $text = "Button"
	Return createCtrlInternal($parentMap.ptr, "gflNewButton", $fullParams, $ctButton, $bCreate, $text, $x, $y, $width, $height )
EndFunc


Func glf_ButtonSetGradient(Byref $btnMap, $clr1, $clr2)
	local $res = DllCall($hDll, "none", "BtnSetGradientColor", "ptr", $btnMap.ptr, "uint", $clr1, "uint", $clr2)
	if @error Then $btnMap.error = @error
EndFunc


Func glf_NewCalendar($parentMap, $x = 0, $y = 0, $bCreate = Default)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	Return createCtrlInternal($parentMap.ptr, "newCalendar", $posAndSize, $ctCalendar, $bCreate, Default, $x, $y, 0, 0 )
EndFunc

Func glf_NewDateAndTime($iYear = @YEAR, $iMonth = @MON, $iDay = @MDAY, $iHour = @HOUR, $iMinute = @MIN, $iSecond = @SEC, $iMillisecond = @MSEC, $iDayOfWeek = @WDAY)

	Local $res = DllCall($hDll, "ptr", "glfNewDateTime", "int", $iYear, "int", $iMonth, "int", $iDay, _
						"int", $iHour, "int", $iMinute, "int", $iSecond, "int", $iMillisecond, "int", $iDayOfWeek)
	Return $res[0]
EndFunc


Func glf_NewCheckBox($parentMap, $txt = Default, $x = 0, $y = 0, $w = 0, $h = 0, $bCreate = Default)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $txt = Default Then $txt = "CheckBox"
	Return createCtrlInternal($parentMap.ptr, "newCheckBox", $fullParams, $ctCheckBox, $bCreate, $txt, $x, $y, $w, $h)
EndFunc


Func glf_NewComboBox($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = Default)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 140
	if $height = 0 Then $height = 27
	Return createCtrlInternal($parentMap.ptr, "newComboBox", $posAndSize, $ctComboBox, $bCreate, Default, $x, $y, $width, $height )
EndFunc

Func glf_ComboAddItem($comboMap, $item)
	local $res = DllCall($hDll, "none", "addComboItem", "ptr", $comboMap.ptr, "wstr", $item)
	if @error Then $comboMap.error = @error
EndFunc

Func glf_ComboAddRange($comboMap, $itemArrOrTxt)
	if IsArray($itemArrOrTxt) Then
		for $item in $itemArrOrTxt
			local $res = DllCall($hDll, "none", "addComboItem", "ptr", $comboMap.ptr, "wstr", $item)
			if @error Then
				$comboMap.error = @error
				ExitLoop
			EndIf
		Next
	Else
		local $res = DllCall($hDll, "none", "addComboItems", "ptr", $comboMap.ptr, "wstr", $itemArrOrTxt)
		if @error Then $comboMap.error = @error
	EndIf
EndFunc

Func glf_ComboRemoveItem($comboMap, $item )
	local $res = DllCall($hDll, "none", "removeComboItem1", "ptr", $comboMap.ptr, "wstr", $item)
	if @error Then $comboMap.error = @error
EndFunc

Func glf_ComboRemoveItemAt($comboMap, $iIndex )
	local $res = DllCall($hDll, "none", "removeComboItem2", "ptr", $comboMap.ptr, "int", $iIndex)
	if @error Then $comboMap.error = @error
EndFunc

Func glf_ComboClearItems($comboMap)
	local $res = DllCall($hDll, "none", "removeAllComboItems", "ptr", $comboMap.ptr)
	if @error Then $comboMap.error = @error
EndFunc


Func glf_NewDateTimePicker($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = Default)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 10
	if $height = 0 Then $height = 10
	Return createCtrlInternal($parentMap.ptr, "newDateTimePicker", $posAndSize, $ctDateTimePicker, $bCreate, Default, $x, $y, $width, $height )
EndFunc


Func glf_NewGroupBox($parentMap, $txt = Default, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 150
	if $height = 0 Then $height = 150
	if $txt = Default Then $txt = "GroupBox"
	Return createCtrlInternal($parentMap.ptr, "newGroupBox", $fullParams, $ctGroupBox, $bCreate, $txt, $x, $y, $width, $height )
EndFunc


Func glf_NewLabel($parentMap, $txt = Default, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $txt = Default Then $txt = "Label"
	Return createCtrlInternal($parentMap.ptr, "newLabel", $fullParams, $ctLabel, $bCreate, $txt, $x, $y, $width, $height )
EndFunc


Func glf_NewListBox($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 140
	if $height = 0 Then $height = 140
	Return createCtrlInternal($parentMap.ptr, "newListBox", $posAndSize, $ctListBox, $bCreate, Default, $x, $y, $width, $height )
EndFunc


Func glf_ListBoxAddRange($listBoxMap, $itemArrOrTxt)
	if IsArray($itemArrOrTxt) Then
		for $item in $itemArrOrTxt
			local $res = DllCall($hDll, "none", "listBoxAddItem", "ptr", $listBoxMap.ptr, "wstr", $item)
			if @error Then
				$listBoxMap.error = @error
				ExitLoop
			EndIf
		Next
	Else
		local $res = DllCall($hDll, "none", "listBoxAddItems", "ptr", $listBoxMap.ptr, "wstr", $itemArrOrTxt)
		if @error Then $listBoxMap.error = @error
	EndIf
EndFunc

Func glf_NewListView($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 280
	if $height = 0 Then $height = 200
	Return createCtrlInternal($parentMap.ptr, "newListView", $posAndSize, $ctListView, $bCreate, Default, $x, $y, $width, $height )
EndFunc

func glf_ListViewAddColumn(Byref $listViewMap, $colTxt, $colWidth = 0, $imageIndex = -1)
	if $colWidth = 0 Then $colWidth = 100
	local $col = DllCall($hDll, "ptr", "lvAddColumn", "ptr", $listViewMap.ptr, _
							"wstr", $colTxt, "int", $colWidth, "int", $imageIndex)
	if @error Then $listViewMap.error = @error
EndFunc

func glf_ListViewAddColumns(Byref $listViewMap, $colTxts, $colWidths = "0")
	local $col = DllCall($hDll, "ptr", "lvAddColumns", "ptr", $listViewMap.ptr, "wstr", $colTxts, "str", $colWidths)
	if @error Then $listViewMap.error = @error
EndFunc

func glf_ListViewAddRow(Byref $listViewMap, $itemsArrOrTxt)
	if IsArray($itemsArrOrTxt) Then
		local $fItem = $itemsArrOrTxt[0]
		local $res = DllCall($hDll, "ptr", "lvAddItem1", "ptr", $listViewMap.ptr, "wstr", $fItem)
		if @error then
			$listViewMap.error = @error
		Else
			for $i = 1 to UBound($itemsArrOrTxt) - 1
				local $r2 = DllCall($hDll, "none", "lvAddSubitem1", "ptr", $res[0], "wstr", $itemsArrOrTxt[$i])
				if @error Then
					$listViewMap.error = @error
					ExitLoop
				EndIf
			Next
		EndIf
	Else
		local $res = DllCall($hDll, "ptr", "lvAddRow", "ptr", $listViewMap.ptr, "wstr", $itemsArrOrTxt)
		if @error Then $listViewMap.error = @error
	EndIf
EndFunc


func glf_ListViewAddItem(Byref $listViewMap, $itemsText, $bgColor = 0xFFFFFF, $fgColor = 0x000000, $imgIndex = -1)
	local $res = DllCall($hDll, "ptr", "listViewAddItem1", "ptr", $listViewMap.ptr, _
							"wstr", $itemsText, "uint", $bgColor, "uint", $fgColor, "int", $imgIndex)
	if @error then
		$listViewMap.error = @error
		return 0
	EndIf
	Return $res[0]
EndFunc

func glf_ListViewAddSubItem1($listViewItem, $subItemText)
	local $res = DllCall($hDll, "none", "listViewAddSubitem1", "ptr", $listViewItem, "wstr", $subItemText)
	if @error then return 0
	Return 1
EndFunc

func glf_ListViewAddSubItem2(Byref $listViewMap, $itemsOrIndex, $subItemText)
	if IsNumber($itemsOrIndex) Then
		glf_ListViewAddSubItem1($itemsOrIndex, $subItemText)
	Else
		local $res = DllCall($hDll, "none", "listViewAddSubitem2", "ptr", $listViewMap.ptr, _
								"int", $itemsOrIndex, "wstr", $subItemText)
	EndIf
	if @error then return 0
	Return 1
EndFunc

Func glf_ListViewSetHeaderFont(ByRef $lvMap, $fontName, $fontSize, $fontWeight = $fwNormal)
	Local $res = DllCall($hDll, "none", "listViewSetHeaderFont", "ptr", $lvMap.ptr, _
							"wstr", $fontName, "int", $fontSize, "int", $fontWeight)
	if @error Then $lvMap.error = @error
EndFunc

Func glf_NewNumberPicker($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 80
	if $height = 0 Then $height = 27
	Return createCtrlInternal($parentMap.ptr, "newNumberPicker", $posAndSize, $ctNumberPicker, $bCreate, Default, $x, $y, $width, $height )
EndFunc

Func glf_NewProgressBar($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 200
	if $height = 0 Then $height = 25
	Return createCtrlInternal($parentMap.ptr, "newProgressBar", $posAndSize, $ctProgressBar, $bCreate, Default, $x, $y, $width, $height )
EndFunc

Func glf_NewRadioButton($parentMap, $txt = Default, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	; if $width = 0 Then $width = 200
	; if $height = 0 Then $height = 25
	if $txt = Default Then $txt = "RadioButton"
	Return createCtrlInternal($parentMap.ptr, "newRadioButton", $fullParams, $ctRadioButton, $bCreate, $txt, $x, $y, $width, $height )
EndFunc

Func glf_NewTextBox($parentMap, $txt = Default, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 120
	if $height = 0 Then $height = 27
	if $txt = Default Then $txt = "TextBox"
	Return createCtrlInternal($parentMap.ptr, "newTextBox", $fullParams, $ctTextBox, $bCreate, $txt, $x, $y, $width, $height )
EndFunc

Func glf_NewTrackBar($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 180
	if $height = 0 Then $height = 45
	Return createCtrlInternal($parentMap.ptr, "newTrackBar", $posAndSize, $ctTrackBar, $bCreate, Default, $x, $y, $width, $height )
EndFunc

Func glf_NewTreeView($parentMap, $x = 0, $y = 0, $width = 0, $height = 0, $bCreate = False)
	if $x = 0 Then $x = 25
	if $y = 0 Then $y = 25
	if $width = 0 Then $width = 250
	if $height = 0 Then $height = 150
	Return createCtrlInternal($parentMap.ptr, "newTreeView", $posAndSize, $ctTreeView, $bCreate, Default, $x, $y, $width, $height )
EndFunc

Func glf_TreeViewAddNode(Byref $tvMap, $nodeTxtOrNode)
	Local $funcName = "tvAddNode2"
	Local $paramType = "ptr"
	if IsString($nodeTxtOrNode) Then
		$funcName = "tvAddNode1"
		$paramType = "wstr"
	EndIf
	Local $res = DllCall($hDll, "ptr", $funcName, "ptr", $tvMap.ptr, $paramType, $nodeTxtOrNode)
	if @error Then $tvMap.error = @error
EndFunc

Func glf_TreeViewAddNodes(Byref $tvMap, $txtOrTxtArr)
	if IsArray($txtOrTxtArr) Then
		For $item in $txtOrTxtArr
			glf_TreeViewAddNode($tvMap, $item)
		Next
	Else
		; It may be a long text with multiple node names and pipe delimiter.
		Local $res = DllCall($hDll, "ptr", "tvAddNodes", "ptr", $tvMap.ptr, "wstr", $txtOrTxtArr)
		if @error Then $tvMap.error = @error
	EndIf
EndFunc

Func glf_TreeViewAddChildNode(ByRef $tvMap, $nodeIndex, $nodeText)
	Local $res = DllCall($hDll, "ptr", "tvAddChildNode3", "ptr", $tvMap.ptr, _
							"int", $nodeIndex, "wstr", $nodeText)
	if @error Then $tvMap.error = @error
EndFunc

Func glf_TreeViewAddChildNodes(ByRef $tvMap, $nodeIndex, $nodeTextArr)
	if IsArray($nodeTextArr) Then
		For $text in $nodeTextArr
			glf_TreeViewAddChildNode($tvMap, $nodeIndex, $text)
		Next
	Else
		Local $funcName = "tvAddChildNodes2"
		Local $paramType = "ptr"
		if IsNumber($nodeIndex) Then
			$funcName = "tvAddChildNodes1"
			$paramType = "int"
		EndIf
		Local $res = DllCall($hDll, "ptr", $funcName, "ptr", $tvMap.ptr, _
							$paramType, $nodeIndex, "wstr", $nodeTextArr)
	if @error Then $tvMap.error = @error
	EndIf
EndFunc

Func glf_TreeNodeAddChildNode($treeNodePtr, $nodeTextOrNode)
	Local $funcName = "treeNodeAddChildNode2"
	Local $paramType = "ptr"
	if IsString($nodeTextOrNode) Then
		$funcName = "treeNodeAddChildNode1"
		$paramType = "wstr"
	EndIf
	Local $res = DllCall($hDll, "ptr", $funcName, "ptr", $treeNodePtr, $paramType, $nodeTextOrNode)
	if @error Then return @error
	Return $res[0]
EndFunc


Func glf_FormAddMenuBar(ByRef $frmMap, $baseMenus)
	Local $mbar = DllCall($hDll, "ptr", "newMenuBarPtr", "ptr", $frmMap.ptr, "wstr", $baseMenus)
	if @error Then $frmMap.error = @error
	setMenuEventsAndPropsValues($frmMap, $mnuMainMenu)
EndFunc

Func glf_FormAddMenuItem(Byref $frmMap, $parentIdOrText, $menuText, $fgColor = 0x000000)
	Local $funcName = "glfAddMenuItem2"
	Local $spType = "int"
	if IsString($parentIdOrText) Then
		$funcName = "glfAddMenuItem1"
		$spType = "wstr"
	EndIf
	Local $id = 0
	Local $res = DllCall($hDll, "ptr", $funcName, "ptr", $frmMap.ptr, $spType, $parentIdOrText, _
							"wstr", $menuText, "uint", $fgColor, "int*", $id)
	if @error Then
		$frmMap.error = @error
		print("result ", @error)
		Return 0
	Else
		Local $menu[]
		$menu.ptr = $res[0]
		$menu.mid = $res[4]
		Return $menu
	EndIf
EndFunc

Func glf_FormAddMenuItems(Byref $frmMap, $parentIdOrText, $menuTxtStr)
	Local $funcName = "glfAddMenuItem2"
	Local $spType = "int"
	if IsString($parentIdOrText) Then
		$funcName = "glfAddMenuItem1"
		$spType = "wstr"
	EndIf
	Local $menuTxtArr = StringSplit($menuTxtStr, "|")
	Local $resArr[$menuTxtArr[0]]
	Local $i = 0
	for $j = 1 to $menuTxtArr[0]
		Local $txt = $menuTxtArr[$j]
		Local $id = 0
		Local $res = DllCall($hDll, "ptr", $funcName, "ptr", $frmMap.ptr, $spType, $parentIdOrText, _
								"wstr", $txt, "uint", 0x000000, "int*", $id)
		if @error Then
			$frmMap.error = @error
			Return 0
		Else
			Local $menu[]
			$menu.ptr = $res[0]
			$menu.mid = $res[4]
			$resArr[$i] = $menu
		EndIf
	Next
	Return $resArr
EndFunc

func glf_ControlSetContextMenu(Byref $controlMap, $menuTexts)
	Local $res = DllCall($hDll, "ptr", "ctrlSetContextMenu", "ptr", $controlMap.ptr, "wstr", $menuTexts)
	if @error Then $controlMap.error = @error
	setMenuEventsAndPropsValues($controlMap, $mnuCMenu)
	Return $res[0]
EndFunc

Func glf_MainMenuAddHandler(ByRef $frmMap, $menuName, $eventId, $funcName)
	Local $pCallback = DllCallbackRegister($funcName, "none", "ptr;ptr")
	Local $pfuncPtr = DllCallbackGetPtr($pCallback)
	_ArrayAdd($fnPtrList, $pCallback)
	Local $res = DllCall($hDll, "none", "setMainMenuEvents", "ptr", $frmMap.ptr, _
							"wstr", $menuName, "int", $eventId, "ptr", $pfuncPtr)
	if @error Then $frmMap.error = @error
EndFunc

Func glf_ContextMenuAddHandler(ByRef $controlMap, $menuName, $eventId, $funcName)
	Local $pCallback = DllCallbackRegister($funcName, "none", "ptr;ptr")
	Local $pfuncPtr = DllCallbackGetPtr($pCallback)
	_ArrayAdd($fnPtrList, $pCallback)
	Local $res = DllCall($hDll, "none", "setContextMenuEvents", "ptr", $controlMap.ptr, _
							"wstr", $menuName, "int", $eventId, "ptr", $pfuncPtr)
	if @error Then $controlMap.error = @error
EndFunc



;--------------------------------------------------
Func OnScriptExit()
	DllClose($hDll)
	Local $count = 0
	for $item in $fnPtrList
		DllCallbackFree($item)
		$count += 1
	Next
	ConsoleWrite("Glance dll closed and " & $count & " callback pointers freed...!" & @CRLF)
EndFunc

