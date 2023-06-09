
; Glance GUI library - Autoit wrapper functions.

#include <Array.au3>
Global $hDll = 0
Local $gcList[1] = ["dummy"]
Local $fnPtrList[0]

func glf_Start()
	$hDll = DllOpen("glance.dll")
	OnAutoItExitRegister("OnScriptExit")
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

Global Enum $maBaseMenu = 1, $maSubMenu, $maSeparator

; region Prop & Event map

	; All controls are inherited from Contro class. So it can use control props.
	; Menu is a control. So use menu props for them.
	Global $gControlProps[]
    $gControlProps.kind = 1 ; type: int, readonly
    $gControlProps.width = 2 ; type: int
    $gControlProps.height = 3 ; type: int
    $gControlProps.xpos = 4 ; type: int
    $gControlProps.ypos = 5 ; type: int
    $gControlProps.ctlID = 6 ; type: int
    $gControlProps.backColor = 7 ; type: uint
    $gControlProps.foreColor = 8 ; type: uint
    $gControlProps.text = 9 ; type: wstr
    $gControlProps.name = 10 ; type: str, readonly
    $gControlProps.handle = 11 ; type: hwnd, readonly
    $gControlProps.contextMenu = 12 ; type: ptr
    $gControlProps.font = 13 ; type: ptr
    $gControlProps.parent = 14 ; type: ptr, readonly

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

    Global $gControlEvents[]
    $gControlEvents.onClick = 1
    $gControlEvents.onDoubleClick = 2
    $gControlEvents.onGotFocus = 3
    $gControlEvents.onLostFocus = 4
    $gControlEvents.onKeyDown = 5 ; KeyEventHandler
    $gControlEvents.onKeyPress = 6 ; KeyPressEventHandler
    $gControlEvents.onKeyUp = 7 ; KeyEventHandler
    $gControlEvents.onMouseDown = 8 ; MouseEventHandler
    $gControlEvents.onMouseEnter = 9
    $gControlEvents.onMouseHover = 10
    $gControlEvents.onMouseLeave = 11
    $gControlEvents.onMouseMove = 12 ; MouseEventHandler
    $gControlEvents.onMouseUp = 13 ; MouseEventHandler
    $gControlEvents.onMouseWheel = 14 ; MouseEventHandler
    $gControlEvents.onRightClick = 15
    $gControlEvents.onRightMouseDown = 16 ; MouseEventHandler
    $gControlEvents.onRightMouseUp = 17 ; MouseEventHandler
    $gControlEvents.onPaint = 18 ; PaintEventHandler
    $gControlEvents.onCmenuShown = 19
    $gControlEvents.onCmenuClose = 20

    Global $gFormProps[]
    $gFormProps.startPos = 15 ; type: int
    $gFormProps.formState = 16 ; type: int
    $gFormProps.formStyle = 17 ; type: int
    $gFormProps.topMost = 18 ; type: bool
    $gFormProps.maximizeBox = 19 ; type: bool
    $gFormProps.minimizeBox = 20 ; type: bool

    Global $gFormEvents[]
    $gFormEvents.onLoad = 21
    $gFormEvents.onMaximize = 22
    $gFormEvents.onMinimize = 23
    $gFormEvents.onRestore = 24
    $gFormEvents.onClosing = 25
    $gFormEvents.onActivate = 26
    $gFormEvents.onDeActivate = 27
    $gFormEvents.onMoving = 28
    $gFormEvents.onMoved = 29
    $gFormEvents.onSizing = 30 ; SizeEventHandler
    $gFormEvents.onSized = 31 ; SizeEventHandler

    Global $gCalendarProps[]
    $gCalendarProps.value = 21 ; type: ptr
    $gCalendarProps.viewMode = 22 ; type: int
    $gCalendarProps.showWeekNumber = 23 ; type: bool
    $gCalendarProps.noTodayCircle = 24 ; type: bool
    $gCalendarProps.noToday = 25 ; type: bool
    $gCalendarProps.noTrailingDates = 26 ; type: bool
    $gCalendarProps.shortDateNames = 27 ; type: bool

    Global $gCalendarEvents[]
    $gCalendarEvents.onSelectionCommitted = 32
    $gCalendarEvents.onValueChanged = 33
    $gCalendarEvents.onViewChanged = 34

    Global $gCheckBoxProps[]
    $gCheckBoxProps.checked = 28 ; type: bool

    Global $gCheckBoxEvents[]
    $gCheckBoxEvents.onCheckedChanged = 35

    Global $gComboProps[]
    $gComboProps.hasInput = 29 ; type: bool
    $gComboProps.selectedIndex = 30 ; type: int
    $gComboProps.selectedItem = 31 ; type: wstr

    Global $gComboEvents[]
    $gComboEvents.onSelectionChanged = 36
    $gComboEvents.onTextChanged = 37
    $gComboEvents.onTextUpdated = 38
    $gComboEvents.onListOpened = 39
    $gComboEvents.onListClosed = 40
    $gComboEvents.onSelectionCommitted = 41
    $gComboEvents.onSelectionCancelled = 42

    Global $gDTPProps[]
    $gDTPProps.formatString = 32 ; type: wstr
    $gDTPProps.value = 33 ; type: ptr
    $gDTPProps.format = 34 ; type: int
    $gDTPProps.rightAlign = 35 ; type: bool
    $gDTPProps.noToday = 36 ; type: bool
    $gDTPProps.showUpdown = 37 ; type: bool
    $gDTPProps.showWeekNumber = 38 ; type: bool
    $gDTPProps.noTodayCircle = 39  ; type: bool
    $gDTPProps.noTrailingDates = 40 ; type: bool
    $gDTPProps.shortDateNames = 41 ; type: bool
    $gDTPProps.fourDigitYear = 42 ; type: bool

    Global $gDTPevents[]
    $gDTPevents.onValueChanged = 43
    $gDTPevents.onCalendarOpened = 44
    $gDTPevents.onCalendarClosed = 45
    $gDTPevents.onTextChanged = 46

    Global $gLabelProps[]
    $gLabelProps.autoSize = 43 ; type: bool
    $gLabelProps.multiLine = 44 ; type: bool
    $gLabelProps.textAlign = 45 ; type: int
    $gLabelProps.borderStyle = 46 ; type: int

    Global $gListBoxEvents[]
    $gListBoxEvents.onSelectionChanged = 47
    $gListBoxEvents.onSelectionCancelled = 48

    Global $gListBoxProps[]
    $gListBoxProps.hotIndex = 47 ; type: int
    $gListBoxProps.selectedIndex = 48 ; type: int
    $gListBoxProps.horizontalScroll = 49 ; type: bool
    $gListBoxProps.verticalScroll = 50 ; type: bool
    $gListBoxProps.multiSelection = 51 ; type: bool
    $gListBoxProps.hotItem = 52 ; type: wstr
    $gListBoxProps.selectedItem = 53 ; type: wstr

    Global $gListViewEvents[]
    $gListViewEvents.onCheckedChanged = 49
    $gListViewEvents.onSelectionChanged = 50
    $gListViewEvents.onItemDoubleClicked = 51
    $gListViewEvents.onItemClicked = 52
    $gListViewEvents.onItemHover = 53

    Global $gListViewProps[]
    $gListViewProps.selectedIndex = 54 ; type: int
    $gListViewProps.selectedSubIndex = 55 ; type: int
    $gListViewProps.headerHeight = 56 ; type: int
    $gListViewProps.editLabel = 57 ; type: bool
    $gListViewProps.hideSelection = 58 ; type: bool
    $gListViewProps.multiSelection = 59 ; type: bool
    $gListViewProps.hasCheckBox = 60 ; type: bool
    $gListViewProps.fullRowSelection = 61 ; type: bool
    $gListViewProps.showGrid = 62 ; type: bool
    $gListViewProps.oneClickActivate = 63 ; type: bool
    $gListViewProps.hotTrackSelection = 64 ; type: bool
    $gListViewProps.headerClickable = 65 ; type: bool
    $gListViewProps.checked = 66 ; type: bool
    $gListViewProps.checkBoxLast = 67 ; type: bool
    $gListViewProps.viewStyle = 68 ; type: int
    $gListViewProps.headerBackColor = 69 ; type: uint
    $gListViewProps.headerForeColor = 70 ; type: uint
    $gListViewProps.selectedItem = 71 ; type: wstr

    Global $gNumberPickerEvents[]
    $gNumberPickerEvents.onValueChanged = 54

    Global $gNumberPickerProps[]
    $gNumberPickerProps.value         = 72 ; type: float
    $gNumberPickerProps.stepp         = 73 ; type: float
    $gNumberPickerProps.minRange      = 74 ; type: float
    $gNumberPickerProps.maxRange      = 75 ; type: float
    $gNumberPickerProps.buttonLeft    = 76 ; type: bool
    $gNumberPickerProps.autoRotate    = 77 ; type: bool
    $gNumberPickerProps.hideCaret     = 78 ; type: bool
    $gNumberPickerProps.textAlign     = 79 ; type: int
    $gNumberPickerProps.decimalDigits = 80 ; type: int

    Global $gProgressBarEvents[]
    $gProgressBarEvents.onProgressChanged = 55

    Global $gProgressBarProps[]
    $gProgressBarProps.value = 81 ;type: int
    $gProgressBarProps.stepp = 82 ;type: int
    $gProgressBarProps.marqueeSpeed = 83 ;type: int
    $gProgressBarProps.style = 84 ;type: int
    $gProgressBarProps.state = 85 ;type: int
    $gProgressBarProps.showPercentage = 86 ;type: bool

    Global $gRadioButtonEvents[]
    $gRadioButtonEvents.onCheckedChanged = 56

    Global $gRadioButtonProps[]
    $gRadioButtonProps.checked = 87 ; type: bool

    Global $gTextBoxEvents[]
    $gTextBoxEvents.onTextChanged = 57

    Global $gTextBoxProps[]
    $gTextBoxProps.textAlign = 88 ; type: int
    $gTextBoxProps.textCase = 89 ; type: int
    $gTextBoxProps.textType = 90 ; type: int
    $gTextBoxProps.multiLine = 91 ; type: bool
    $gTextBoxProps.hideSelection = 92 ; type: bool
    $gTextBoxProps.readOnly = 93 ; type: bool
    $gTextBoxProps.cueBanner = 94 ; type: wstr

    Global $gTrackBarEvents[]
    $gTrackBarEvents.onValueChanged = 58
    $gTrackBarEvents.onDragging = 59
    $gTrackBarEvents.onDragged = 60

    Global $gTrackBarProps[]
    $gTrackBarProps.ticColor = 95 ; type: int
    $gTrackBarProps.channelColor = 96 ; type: uint
    $gTrackBarProps.selectionColor = 97 ; type: uint
    $gTrackBarProps.channelStyle = 98 ; type: int
    $gTrackBarProps.trackChange = 99 ; type: int
    $gTrackBarProps.vertical = 100 ; type: bool
    $gTrackBarProps.reversed = 101 ; type: bool
    $gTrackBarProps.noTics = 102 ; type: bool
    $gTrackBarProps.showSelRange = 103 ; type: bool
    $gTrackBarProps.toolTipp = 104 ; type: bool
    $gTrackBarProps.customDraw = 105 ; type: bool
    $gTrackBarProps.freeMove = 106 ; type: bool
    $gTrackBarProps.noThumb = 107 ; type: bool
    $gTrackBarProps.ticPosition = 108 ; type: int
    $gTrackBarProps.ticWidth = 109 ; type: int
    $gTrackBarProps.minRange = 110 ; type: float
    $gTrackBarProps.maxRange = 111 ; type: float
    $gTrackBarProps.frequency = 112 ; type: float
    $gTrackBarProps.pageSize = 113 ; type: int
    $gTrackBarProps.lineSize = 114 ; type: int
    $gTrackBarProps.ticLength = 115 ; type: int
    $gTrackBarProps.value = 116 ; type: int

    Global $gTreeViewEvents[]
    $gTreeViewEvents.onBeginEdit = 61
    $gTreeViewEvents.onEndEdit = 62
    $gTreeViewEvents.onNodeDeleted = 63
    $gTreeViewEvents.onBeforeChecked = 64 ; TreeEventHandler
    $gTreeViewEvents.onAfterChecked = 65 ; TreeEventHandler
    $gTreeViewEvents.onBeforeSelected = 66 ; TreeEventHandler
    $gTreeViewEvents.onAfterSelected = 67 ; TreeEventHandler
    $gTreeViewEvents.onBeforeExpanded = 68 ; TreeEventHandler
    $gTreeViewEvents.onAfterExpanded = 69 ; TreeEventHandler
    $gTreeViewEvents.onBeforeCollapsed = 70 ; TreeEventHandler
    $gTreeViewEvents.onAfterCollapsed = 71 ; TreeEventHandler

    Global $gTreeViewPropss[]
    $gTreeViewPropss.noLine = 117 ; type: bool
    $gTreeViewPropss.noButton = 118 ; type: bool
    $gTreeViewPropss.hasCheckBox = 119 ; type: bool
    $gTreeViewPropss.fullRowSelect = 120 ; type: bool
    $gTreeViewPropss.isEditable = 121 ; type: bool
    $gTreeViewPropss.showSelection = 122 ; type: bool
    $gTreeViewPropss.hotTrack = 123 ; type: bool
    $gTreeViewPropss.nodeCount = 124 ; type: int
    $gTreeViewPropss.uniqNodeID = 125 ; type: int, readonly
    $gTreeViewPropss.lineColor = 126 ; type: uint
    $gTreeViewPropss.selectedNode = 127 ; type: ptr

    Global $gMenuEvents[]
    $gMenuEvents.onClick = 72 ; MenuEventHandler
    $gMenuEvents.onPopup = 73 ; MenuEventHandler
    $gMenuEvents.onCollapse = 74 ; MenuEventHandler
    $gMenuEvents.onFocus = 75 ; MenuEventHandler

    Global $gMenuProps[]
    $gMenuProps.cmWidth = 128 ; type: int
    $gMenuProps.cmHeight = 129 ; type: int
    $gMenuProps.cmFont = 130 ; type: ptr
    $gMenuProps.cmParent = 131 ; type: ptr
    $gMenuProps.cmHmenu = 132 ; type: HMENU
    $gMenuProps.mbHmenu = 133 ; type: HMENU
    $gMenuProps.mbFont = 134 ; type: ptr
    $gMenuProps.mbParent = 135 ; type: ptr
    $gMenuProps.mbMenuCount = 136 ; type: int
    $gMenuProps.miChildCount = 137 ; type: int
    $gMenuProps.miIndex = 138 ; type: int
    $gMenuProps.miType = 139 ; type: int
    $gMenuProps.miBackColor = 140 ; type: uint
    $gMenuProps.miForeColor = 141 ; type: uint
    $gMenuProps.miFont = 142 ; type: ptr
    $gMenuProps.miHmenu = 143 ; type: HMENU
    $gMenuProps.miText = 144 ; type: wstr

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

