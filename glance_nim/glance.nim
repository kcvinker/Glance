include apimodule
include winmessages
include typemodule
include colors
include commons
include events
include controls
include forms

include button
include calendar
include checkbox
include combobox
include datetimepicker
include groupbox
include label
include listbox
include listview
include numberpicker
include progressbar
include radiobutton
include textbox
include trackbar
include treeview


# import tables
const
    auStrLimit = 65536

# var typeDic = {"byte": byte, "bool": bool, "char": char, "dword": DWORD}.toTable #Table[string, typedesc]


# Convert wchar ptr to wchar array. Not null terminated
proc wcharPtrToArray(p: LPCWSTR) : seq[WCHAR] =
    let iptr = cast[int](p)
    var i = 0
    while i < auStrLimit:
        let nextPtr = iptr + (i * 2)
        let pWchar = cast[LPWSTR](nextPtr)
        if ord(pWchar[]) == 0: break
        result.add(pWchar[])
        i += 1

# Convert wchar ptr to wchar array. Null terminated
proc wcharPtrToArrayZ(p: LPCWSTR) : seq[WCHAR] =
    let iptr = cast[int](p)
    var i = 0
    while i < auStrLimit:
        let nextPtr = iptr + (i * 2)
        let pWchar = cast[LPWSTR](nextPtr)
        result.add(pWchar[])
        if ord(pWchar[]) == 0: break
        i += 1


proc createControlHandles(this: Form) =
    if this.mMenu != nil: this.mMenu.createMenuBarHandle()
    if this.controls.len > 0:
        for ctl in this.controls:
            if not ctl.mIsCreated: ctl.createHandle()



# Creates all control hwnds and returns the count
#proc createControlHwnds(this: Form): int {.exportc:"createControlHwnds", stdcall, dynlib.} =
#    this.tmpHwndSeq = @[]
#    if this.controls.len > 0:
#        for ctl in this.controls:
#            if not ctl.mIsCreated:
#                ctl.createHandle()
#                this.tmpHwndSeq.add(ctl.mHandle)
#                result += 1

proc display(this: Form ) {.exportc:"frmDisplay", stdcall, dynlib.} =
    this.createControlHandles()
    ShowWindow(this.mHandle, 5)
    UpdateWindow(this.mHandle)
    if not appData.loopStarted:
        appData.loopStarted = true
        appData.mainHwnd = this.mHandle
        mainLoop()

proc createControlHwnd(this: Control): HWND {.exportc:"createControlHwnd", stdcall, dynlib.} =
   this.createHandle()
   result = this.mHandle


proc getHwndSeqItem(this: Form, index: int) : HWND {.exportc:"getHwndSeqItem", stdcall, dynlib.} =
    if this.tmpHwndSeq.len > 0:
        result = this.tmpHwndSeq[index]

proc clearHwndSeq(this: Form) {.exportc:"clearHwndSeq", stdcall, dynlib.} = this.tmpHwndSeq = @[]

proc makeTable[T, U](key: typedesc[T], value: typedesc[U]) : Table[T, U] =
    var tp = Table[key, value]
    return tp




proc setEventHandler(this: Control, evtIndex: int, funcPtr: EventHandler) {.exportc:"setEventHandler", stdcall, dynlib.} =
    case evtIndex
    of int(ControlEvents.low) .. int(ControlEvents.high):
        setCtrlEvents(this, cast[ControlEvents](evtIndex), funcPtr)

    of int(FormEvents.low) .. int(FormEvents.high):
        setFormEvents(cast[Form](this), cast[FormEvents](evtIndex), funcPtr)

    of int(CalendarEvents.low) .. int(CalendarEvents.high):
        setCalEvents(cast[Calendar](this), cast[CalendarEvents](evtIndex), funcPtr)

    of int(CheckBoxEvents.cbCheckedChanged):
        setCheckBoxEvents(cast[CheckBox](this), cast[CheckBoxEvents](evtIndex), funcPtr)

    of int(ComboBoxEvents.low) .. int(ComboBoxEvents.high):
        setComboBoxEvents(cast[ComboBox](this), cast[ComboBoxEvents](evtIndex), funcPtr)

    of int(DateTimePickerEvents.low) .. int(DateTimePickerEvents.high):
        setDateTimePickerEvents(cast[DateTimePicker](this), cast[DateTimePickerEvents](evtIndex), funcPtr)

    of int(ListBoxEvents.low) .. int(ListBoxEvents.high):
        setListBoxEvents(cast[ListBox](this), cast[ListBoxEvents](evtIndex), funcPtr)

    of int(ListViewEvents.low) .. int(ListViewEvents.high):
        setListViewEvents(cast[ListView](this), cast[ListViewEvents](evtIndex), funcPtr)

    of int(NumberPickerEvents.npValueChanged):
        cast[NumberPicker](this).onValueChanged = funcPtr

    of int(ProgressBarEvents.pbProgressChanged):
        cast[ProgressBar](this).onProgressChanged = funcPtr

    of int(RadioButtonEvents.rbCheckedChanged):
        cast[RadioButton](this).onCheckedChanged = funcPtr

    of int(TextBoxEvents.tbTextChanged):
        cast[TextBox](this).onTextChanged = funcPtr

    of int(TrackBarEvents.low) .. int(TrackBarEvents.high):
        setTrackBarEvents(cast[TrackBar](this), cast[TrackBarEvents](evtIndex), funcPtr)

    of int(TreeViewEvents.low) .. int(TreeViewEvents.high):
        setTreeViewEvents(cast[TreeView](this), cast[TreeViewEvents](evtIndex), funcPtr)

    of int(MenuEvents.low):
        this.mContextMenu.onMenuShown = cast[ContextMenuEventHandler](funcPtr)
    of int(MenuEvents.low) + 1:
        this.mContextMenu.onMenuClose = cast[ContextMenuEventHandler](funcPtr)

    else: discard

proc setProperty(this: Control, propIndex: int, pValue: pointer){.exportc:"setProperty", stdcall, dynlib.} =
    case propIndex
    of int(ControlProps.low) .. int(ControlProps.high):
        setCtrlProps(this, cast[ControlProps](propIndex), pValue)

    of int(FormProps.low) .. int(FormProps.high):
        setFormProps(cast[Form](this), cast[FormProps](propIndex), pValue)

    of int(CalendarProps.low) .. int(CalendarProps.high):
        setCalProps(cast[Calendar](this), cast[CalendarProps](propIndex), pValue)

    of int(CheckBoxProps.cbChecked):
        setCheckBoxProps(cast[CheckBox](this), cast[CheckBoxProps](propIndex), pValue)

    of int(ComboBoxProps.low) .. int(ComboBoxProps.high):
        setComboBoxProps(cast[ComboBox](this), cast[ComboBoxProps](propIndex), pValue)

    of int(DateTimePickerProps.low) .. int(DateTimePickerProps.high):
        setDateTimePickerProps(cast[DateTimePicker](this), cast[DateTimePickerProps](propIndex), pValue)

    of int(LabelProps.low) .. int(LabelProps.high):
        setLabelProps(cast[Label](this), cast[LabelProps](propIndex), pValue)

    of int(ListBoxProps.low) .. int(ListBoxProps.high):
        setListBoxProps(cast[ListBox](this), cast[ListBoxProps](propIndex), pValue)

    of int(ListViewProps.low) .. int(ListViewProps.high):
        setListViewProps(cast[ListView](this), cast[ListViewProps](propIndex), pValue)

    of int(NumberPickerProps.low) .. int(NumberPickerProps.high):
        setNumberPickerProps(cast[NumberPicker](this), cast[NumberPickerProps](propIndex), pValue)

    of int(ProgressBarProps.low) .. int(ProgressBarProps.high):
        setProgressBarProps(cast[ProgressBar](this), cast[ProgressBarProps](propIndex), pValue)

    of int(RadioButtonProps.rbChecked):
        cast[RadioButton](this).checked = cast[bool](cast[ref int](pValue)[])

    of int(TextBoxProps.low) .. int(TextBoxProps.high):
        setTextBoxProps(cast[TextBox](this), cast[TextBoxProps](propIndex), pValue)

    of int(TrackBarProps.low) .. int(TrackBarProps.high):
        setTrackBarProps(cast[TrackBar](this), cast[TrackBarProps](propIndex), pValue)

    of int(TreeViewProps.low) .. int(TreeViewProps.high):
        setTreeViewProps(cast[TreeView](this), cast[TreeViewProps](propIndex), pValue)

    of int(ContextMenuProps.low) .. int(ContextMenuProps.high):
        if this.mContextMenu != nil:
            setContextMenuProps(this.mContextMenu, cast[ContextMenuProps](propIndex), pValue)
        else:
            raise newException(Exception, "No context menu assaigned for this control")

    else: discard

proc getProperty(this: Control, propIndex: int, pValue: pointer) {.exportc:"getProperty", stdcall, dynlib.} =
    case propIndex
    of int(ControlProps.low) .. int(ControlProps.high):
        getCtrlProps(this, cast[ControlProps](propIndex), pValue)

    of int(FormProps.low) .. int(FormProps.high):
        getFormProps(cast[Form](this), cast[FormProps](propIndex), pValue)

    of int(CalendarProps.low) .. int(CalendarProps.high):
        getCalProps(cast[Calendar](this), cast[CalendarProps](propIndex), pValue)

    of int(CheckBoxProps.cbChecked):
        getCheckBoxProps(cast[CheckBox](this), cast[CheckBoxProps](propIndex), pValue)

    of int(ComboBoxProps.low) .. int(ComboBoxProps.high):
        getComboBoxProps(cast[ComboBox](this), cast[ComboBoxProps](propIndex), pValue)

    of int(DateTimePickerProps.low) .. int(DateTimePickerProps.high):
        getDateTimePickerProps(cast[DateTimePicker](this), cast[DateTimePickerProps](propIndex), pValue)

    of int(LabelProps.low) .. int(LabelProps.high):
        getLabelProps(cast[Label](this), cast[LabelProps](propIndex), pValue)

    of int(ListBoxProps.low) .. int(ListBoxProps.high):
        getListBoxProps(cast[ListBox](this), cast[ListBoxProps](propIndex), pValue)

    of int(ListViewProps.low) .. int(ListViewProps.high):
        getListViewProps(cast[ListView](this), cast[ListViewProps](propIndex), pValue)

    of int(NumberPickerProps.low) .. int(NumberPickerProps.high):
        getNumberPickerProps(cast[NumberPicker](this), cast[NumberPickerProps](propIndex), pValue)

    of int(ProgressBarProps.low) .. int(ProgressBarProps.high):
        getProgressBarProps(cast[ProgressBar](this), cast[ProgressBarProps](propIndex), pValue)

    of int(RadioButtonProps.rbChecked):
        cast[ref bool](pValue)[] = cast[RadioButton](this).checked

    of int(TextBoxProps.low) .. int(TextBoxProps.high):
        getTextBoxProps(cast[TextBox](this), cast[TextBoxProps](propIndex), pValue)

    of int(TrackBarProps.low) .. int(TrackBarProps.high):
        getTrackBarProps(cast[TrackBar](this), cast[TrackBarProps](propIndex), pValue)

    of int(TreeViewProps.low) .. int(TreeViewProps.high):
        getTreeViewProps(cast[TreeView](this), cast[TreeViewProps](propIndex), pValue)

    of int(ContextMenuProps.low) .. int(ContextMenuProps.high):
        if this.mContextMenu != nil:
            getContextMenuProps(this.mContextMenu, cast[ContextMenuProps](propIndex), pValue)
        else:
            raise newException(Exception, "No context menu assaigned for this control")

    else: discard


















