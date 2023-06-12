#AutoIt3Wrapper_UseX64=y
#include "glance.au3"

Local $frm = glf_NewForm("My Autoit window in Nim", 1100, 500) ; Create new Form aka Window
glf_FormCreateHwnd($frm) ; Create the form's handle

glf_FormAddMenuBar($frm, "File|Edit|Help") ; Create a menubar for this form
glf_FormAddMenuItems($frm, "File", "New Job|Remove Job|Exit") ; Add some sub menus for 'File' & 'Edit' menus
glf_FormAddMenuItems($frm, "Edit", "Format|Font")
glf_FormAddMenuItems($frm, "New Job", "Basic Job|Intermediate Job|Review Job") ; Add some submenus to 'New Job'
glf_MainMenuAddHandler($frm, "Basic Job", $gMenuEvents.onClick, "menuClick"); Add an event handler for 'Basic Job'

Local $btn1 = glf_NewButton($frm, "Normal", 15) ; Now create some buttons
Local $btn2 = glf_NewButton($frm, "Flat", 127)
Local $btn3 = glf_NewButton($frm, "Gradient", 240)
glf_ControlSetProperty($btn2, $gControlProps.backColor, 0x90be6d) ; Set back color property
glf_ButtonSetGradient($btn3, 0xf9c74f, 0xf3722c) ; make this button gradient
glf_ControlAddHandler($btn1, $gControlEvents.onClick, "onBtnClick") ; Add an event handler for btn1

Local $cal = glf_NewCalendar($frm, 15, 70) ; A simple calendar control.

Local $cb1 = glf_NewCheckBox($frm, "Compress", 40, 280) ; Create two checkboxes
Local $cb2 = glf_NewCheckBox($frm, "Extract", 40, 310)
glf_ControlSetProperty($cb2, $gControlProps.foreColor, 0xad2831) ; Set the checked property to True

Local $cmb = glf_NewComboBox($frm, 350, 25) ; Create new ComboBox
glf_ComboAddRange($cmb, "Windows|Linux|Mac|ReactOS") ; Add some items. You can use an array also
glf_ControlSetProperty($cmb, $gControlProps.backColor, 0x68d8d6) ; Set the back color

Local $dtp = glf_NewDateTimePicker($frm, 350, 72) ; Create new DateTimePicker aka DTP

Local $gb = glf_NewGroupBox($frm, "My Groupbox", 25, 250, 155, 100) ; Create new GroupBox
glf_ControlSetProperty($gb, $gControlProps.foreColor, 0x1a659e) ; Set the fore color

Local $lbl = glf_NewLabel($frm, "Static Label", 260, 370) ; Create a Label
glf_ControlSetProperty($lbl, $gControlProps.foreColor, 0x008000) ; Set the fore color

Local $lbx = glf_NewListBox($frm, 500, 25) ; Create a ListBox
glf_ListBoxAddRange($lbx, "Windows|Linux|Mac OS|ReactOS") ; Add some items
glf_ControlSetProperty($lbx, $gControlProps.backColor, 0xffc2d4); Set the back color

Local $lv = glf_NewListView($frm, 270, 161, 330, 150) ; Create a ListView
glf_ListViewSetHeaderFont($lv, "Gabriola", 18) ; Set header font
glf_ControlSetProperty($lv, $gListViewProps.headerHeight, 32) ; Set header height
glf_ControlSetProperty($lv, $gListViewProps.headerBackColor, 0x2ec4b6) ; Set header back color
glf_ControlSetProperty($lv, $gControlProps.backColor, 0xadb5bd) ; Set list view back color
glf_ListViewAddColumns($lv, "Windows|Linux|Mac OS", "0") ; Add three columns
glf_ListViewAddRow($lv, "Win 8|Mint|OSx Cheetah") ; Add few rows
glf_ListViewAddRow($lv, "Win 10|Ubuntu|OSx Catalina")
glf_ListViewAddRow($lv, "Win 11|Kali|OSx Ventura")
Local $cmenu = glf_ControlSetContextMenu($lv, "Forums|General|GUI Help|Dev Help") ; Add a context menu to list view

Local $np1 = glf_NewNumberPicker($frm, 385, 114) ; Create two new NumberPicker aka Updown control
Local $np2 = glf_NewNumberPicker($frm, 300, 114)
glf_ControlSetProperty($np2, $gNumberPickerProps.buttonLeft, True) ; Set the buttons position to left. Default is right
glf_ControlSetProperty($np2, $gControlProps.backColor, 0xeeef20) ; Set back color
glf_ControlSetProperty($np2, $gNumberPickerProps.decimalDigits, 2) ; Set the decimal precision to two
glf_ControlSetProperty($np2, $gNumberPickerProps.stepp, 0.25) ; Set the step value to 0.25

Local $pgb = glf_NewProgressBar($frm, 25, 363) ; Create a progressbar
glf_ControlCreateHwnd($pgb)
glf_ControlSetProperty($pgb, $gProgressBarProps.value, 30) ; Set the value to 30%
glf_ControlSetProperty($pgb, $gProgressBarProps.showPercentage, True) ; We can show the percentage in digits

Local $rb1 = glf_NewRadioButton($frm, "Compiled", 655, 25) ; Create new RadioButtons
Local $rb2 = glf_NewRadioButton($frm, "Interpreted", 655, 55)
glf_ControlSetProperty($rb1, $gRadioButtonProps.checked, True) ; Set one of them checked

Local $tb = glf_NewTextBox($frm, "Some text", 270, 326, 150) ; Create a new TextBox
glf_ControlSetProperty($tb, $gControlProps.foreColor, 0xd80032) ; Set the foreColor

Local $tkb1 = glf_NewTrackBar($frm, 760, 351) ; Create new TrackBars
Local $tkb2 = glf_NewTrackBar($frm, 540, 351)
glf_ControlSetProperty($tkb1, $gTrackBarProps.customDraw, True) ; If set to True, we can change lot of aesthetic effects
glf_ControlSetProperty($tkb2, $gTrackBarProps.customDraw, True)
glf_ControlSetProperty($tkb1, $gTrackBarProps.showSelRange, True) ; We can see the selection are in different color.
glf_ControlSetProperty($tkb2, $gTrackBarProps.ticColor, 0xff1654) ; Set tic color
;;glf_ControlSetProperty($tkb2, $gTrackBarProps.channelColor, 0x006d77) ; Set channel color.

Local $tv = glf_NewTreeView($frm, 760, 25, 0, 300) ; Create new TreeView
glf_ControlSetProperty($tv, $gControlProps.backColor, 0xa3b18a) ; Set back color
glf_ControlCreateHwnd($tv)
glf_TreeViewAddNodes($tv, "Windows|Linux1|MacOS|ReactOS" ) ; Add some nodes

glf_TreeViewAddChildNodes($tv, 0, "Win 7|Win 8|Win 10|Win 11") ; Add some child nodes
glf_TreeViewAddChildNodes($tv, 1, "Mint|Ubuntu|Red Hat|Kali")
glf_TreeViewAddChildNodes($tv, 2, "OSx Cheetah|OSx Leopard|OSx Catalina|OSx Ventura")


; func onBtnClick($c, $e) ; $c = sender of this event aka, the button itself. $e = EventArgs, like in .NET
; 	print("Calendar view mode", glf_ControlGetProperty($cb1, $gControlProps.width))
; EndFunc

func menuClick($m, $e) ; Here $m is menu itself. $e is MenuEventArgs
	print("Menu clicked", $m)
EndFunc

glf_FormShow($frm.ptr) ; All set, just show the form