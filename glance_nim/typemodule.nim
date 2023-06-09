# Type module
import tables

type
    ControlType* {.pure.} = enum
        ctNone, ctButton, ctCalendar, ctCheckBox, ctComboBox, ctDateTimePicker, ctForm, ctGroupBox, ctLabel,
        ctListBox, ctListView, ctNumberPicker, ctProgressBar, ctRadioButton, ctTextBox, ctTrackBar, ctTreeView

    ControlEvents = enum
        ceClick = 1, ceDoubleClick, ceGotFocus, ceLostFocus, ceKeyDown, ceKeyPress, ceKeyUp, ceMouseDown, ceMouseEnter,
        ceMouseHover, ceMouseLeave, ceMouseMove, ceMouseUp, ceMouseWheel, ceRightClick, ceRightMouseDown,
        ceRightMouseUp, cePaint, ceCmMenuShown, ceCmMenuClose

    FormEvents = enum
        feLoad = int(ControlEvents.high) + 1, feMaximize, feMinimize, feRestore, feClosing,
                    feActivate, feDeActivate, feMoving, feMoved, feSizing, feSized

    CalendarEvents = enum
        calSelectionCommitted = int(FormEvents.high) + 1, calValueChanged, calViewChanged

    CheckBoxEvents* = enum
        cbCheckedChanged = int(CalendarEvents.high) + 1

    ComboBoxEvents = enum
        cmbSelectionChanged = int(CheckBoxEvents.high) + 1, cmbTextChanged, cmbTextUpdated,
        cmbListOpened, cmbListClosed, cmbSelectionCommitted, cmbSelectionCancelled

    DateTimePickerEvents = enum
        dtpValueChanged = int(ComboBoxEvents.high) + 1, dtpCalendarOpened, dtpCalendarClosed,
        dtpTextChanged

    ListBoxEvents = enum
        lbxSelectionChanged = int(DateTimePickerEvents.high) + 1, lbxSelectionCancelled

    ListViewEvents = enum
        lvCheckedChanged = int(ListBoxEvents.high) + 1, lvSelectionChanged, lvItemDoubleClicked,
        lvItemClicked, lvItemHover

    NumberPickerEvents = enum
        npValueChanged = int(ListViewEvents.high) + 1

    ProgressBarEvents = enum
        pbProgressChanged = int(NumberPickerEvents.high) + 1

    RadioButtonEvents = enum
        rbCheckedChanged = int(ProgressBarEvents.high) + 1

    TextBoxEvents = enum
        tbTextChanged = int(RadioButtonEvents.high) + 1

    TrackBarEvents = enum
        tkbValueChanged = int(TextBoxEvents.high) + 1, tkbDragging, tkbDragged

    TreeViewEvents = enum
        tvBeginEdit = int(TrackBarEvents.high) + 1, tvEndEdit, tvNodeDeleted, tvBeforeChecked, tvAfterChecked,
        tvBeforeSelected, tvAfterSelected, tvBeforeExpanded, tvAfterExpanded, tvBeforeCollapsed, tvAfterCollapsed

    MenuEvents = enum
        meMiClick = int(TreeViewEvents.high) + 1, meMiPopup, meMiCollapse, meMiFocus

#*******************************************************************************************

    ControlProps = enum
        cpKind = 1, cpWidth, cpHeight, cpXpos, cpYpos, cpCtlID, cpBackColor, cpForeColor, cpText, cpName, cpHandle,
        cpContextMenu,  cpFont, cpParent

    FormProps = enum
        fpFormPos = int(ControlProps.high) + 1, fpFormState, fpFormStyle, fpTopMost, fpMaxBox, fpMinBox

    CalendarProps = enum
        calValue = int(FormProps.high) + 1, calViewMode, calShowWeekNumber, calNoTodayCircle, calNoToday,
        calNoTrailingDates, calShortDateNames

    CheckBoxProps = enum
        cbChecked = int(CalendarProps.high) + 1

    ComboBoxProps = enum
        cmbHasInput = int(CheckBoxProps.high) + 1, cmbSelectedIndex, cmbSelctedItem

    DateTimePickerProps = enum
        dtpFormatString = int(ComboBoxProps.high) + 1, dtpValue, dtpFormat, dtpRightAlign, dtpNoToday,
        dtpShowUpdown, dtpShowWeekNumber, dtpNoTodayCircle, dtpNoTrailingDates, dtpShortDateNames, dtpFourDigitYear

    LabelProps = enum
        lblAutoSize = int(DateTimePickerProps.high) + 1, lblMultiLine, lblTextAlign, lblBorderStyle

    ListBoxProps = enum
        lbxHotIndex = int(LabelProps.high) + 1, lbxSelectedIndex, lbxHorizontalScroll,
        lbxVerticalScroll, lbxMultiSelection, lbxHotItem, lbxSelectedItem

    ListViewProps = enum
        lvSelectedIndex = int(ListBoxProps.high) + 1, lvSelectedSubIndex, lvHeaderHeight, lvEditLabel, lvHideSelection,
        lvMultiSelection, lvHasCheckBox, lvFullRowSelection, lvShowGrid, lvOneClickActivate, lvHotTrackSelection,
        lvHeaderClickable, lvChecked, lvCheckBoxLast, lvViewStyle, lvHeaderBackColor, lvHeaderForeColor, lvSelectedItem

    NumberPickerProps = enum
        npValue = int(ListViewProps.high) + 1, npStep, npMinRange, npMaxRange, npButtonLeft, npAutoRotate, npHideCaret,
        npTextAlign, npDecimalDigits

    ProgressBarProps = enum
        pgbValue = int(NumberPickerProps.high) + 1, pgbStep, pgbMarqueeSpeed, pgbStyle, pgbState, pgbShowPercentage

    RadioButtonProps = enum
        rbChecked = int(ProgressBarProps.high) + 1

    TextBoxProps = enum
        tbTextAlign = int(RadioButtonProps.high) + 1, tbTextCase, tbTextType, tbMultiLine, tbHideSelection,
        tbReadOnly, tbCueBanner

    TrackBarProps = enum
        tkbTicColor = int(TextBoxProps.high) + 1, tkbChannelColor, tkbSelectionColor, tkbChannelStyle, tkbTrackChange
        tkbVertical, tkbReversed, tkbNoTics, tkbShowSelRange, tkbToolTip, tkbCustomDraw, tkbFreeMove, tkbNoThumb,
        tkbTicPosition, tkbTicWidth, tkbMinRange, tkbMaxRange, tkbFrequency, tkbPageSize, tkbLineSize, tkbTicLength, tkbValue,

    TreeViewProps = enum
        tvNoLine = int(TrackBarProps.high) + 1, tvNoButton, tvHasCheckBox, tvFullRowSelect, tvIsEditable,
        tvShowSelection, tvHotTrack, tvNodeCount, tvUniqNodeID, tvLineColor, tvSelectedNode

    ContextMenuProps = enum
        cmWidth = int(TreeViewProps.high) + 1, cmHeight, cmFont, cmParent, cmHmenu

    MenuBarProps = enum
        mbHmenu = int(ContextMenuProps.high) + 1, mbFont, mbParent, mbMenuCount

    MenuItemProps = enum
        miChildCount = int(MenuBarProps.high) + 1, miIndex, miType, miBackColor, miForeColor, miFont, miHmenu, miText




#=============================================================================
    Color* = object
        red*, green*, blue*, value*: uint
        cref*: COLORREF

    FontWeight* {.pure.} = enum
        fwLight = 300, fwNormal = 400, fwMedium = 500, fwSemiBold = 600, fwBold = 700,
        fwExtraBold = 800, fwUltraBold = 900

    Font* = ref object
        name*: wstring
        size*: int32
        weight*: FontWeight
        italics*, underLine*, strikeOut*: bool
        handle: HFONT

    TextAlignment* {.pure.} = enum
        taLeft, taCenter, taRight

    EventArgs* = ref object of RootObj
        handled*: bool
        cancelled*: bool

    EventHandler* = proc(c: Control, e: EventArgs) {.stdcall.}

    PaintEventArgs = ref object of EventArgs
        paintStruct : LPPAINTSTRUCT


    PaintEventHandler = proc(c: Control, e: PaintEventArgs) {.stdcall.}

    ContextMenuEventHandler* = proc(c: ContextMenu, e: EventArgs) {.stdcall.}

    MenuEventHandler* = proc(m: MenuItem, e: EventArgs) {.stdcall.}

    MouseButtons* {.pure.} = enum
        mbNone, mbLeft = 10_48_576, mbRight = 20_97_152, mbMiddle = 41_94_304,
        mbXButton1 = 83_88_608, mbXButton2 = 167_77_216

    MouseEventArgs* = ref object of EventArgs
        mx*, my*, mDelta: int32
        mShiftPressed, mCtrlPressed: bool
        mButton: MouseButtons

    MouseEventHandler* = proc(c: Control, e: MouseEventArgs) {.stdcall.}

    KeyEventArgs* = ref object of EventArgs
        mAltPressed, mCtrlPressed, mShiftPressed: bool
        mKeyValue, mKeyData, mModifier: int32
        mKeyCode: Keys

    KeyEventHandler* = proc(c: Control, e: KeyEventArgs) {.stdcall.}

    KeyPressEventArgs* = ref object of EventArgs
        keyChar*: char

    KeyPressEventHandler* = proc(c: Control, e: KeyPressEventArgs) {.stdcall.}

    Area* = object
        width*, height*: int32

    SizeEventArgs* = ref object of EventArgs
        mWinRect: LPRECT
        mClientArea: Area

    SizeEventHandler* = proc(c: Control, e: SizeEventArgs) {.stdcall.}

    DateTimeEventArgs* = ref object of EventArgs
        mDateStr: string
        mDateStruct: LPSYSTEMTIME

    DateTimeEventHandler* = proc(c: Control, e: DateTimeEventArgs) {.stdcall.}

    TreeViewAction* {.pure.} = enum
        tvaUnknown, tvaByKeyboard, tvaByMouse, tvaCollapse, tvaExpand

    TreeEventArgs* = ref object of EventArgs
        mAction: TreeViewAction
        mNode, mOldNode: TreeNode
        mNewState, mOldState: UINT

    TreeEventHandler* = proc(c: Control, e: TreeEventArgs) {.stdcall.}

    WndProcHandler* = proc(hwnd: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM): LRESULT {.stdcall.}

    CreateFuncPtr = proc(c: Control) {.stdcall.}

    Control* = ref object of RootObj # Base class for all controls
        mKind: ControlType
        mText: wstring
        mName, mClassName: string
        mHandle: HWND
        mBackColor: Color
        mForeColor: Color
        mContextMenu : ContextMenu
        mWidth, mHeight, mXpos, mYpos, mCtlID, mKeyModifier, mKeyMod: int32
        mStyle, mExStyle: DWORD
        mDrawMode: uint32
        mIsCreated, mLbDown, mRbDown, mIsMouseEntered, mHasText: bool
        mBkBrush: HBRUSH
        mFont: Font
        createFunc: CreateFuncPtr
        mParent: Form

        #Events
        onMouseEnter*, onClick*, onMouseLeave*, onRightClick*, onDoubleClick*: EventHandler
        onLostFocus*, onGotFocus*: EventHandler
        onMouseWheel*, onMouseHover*, onMouseMove*, onMouseDown*, onMouseUp*: MouseEventHandler
        onRightMouseDown*, onRightMouseUp*: MouseEventHandler
        onKeyDown*, onKeyUp*: KeyEventHandler
        onKeyPress*: KeyPressEventHandler
        onPaint*: PaintEventHandler

    FormPos* {.pure.} = enum
        fpCenter, fpTopLeft, fpTopMid, fpTopRight, fpMidLeft, fpMidRight,
        fpBottomLeft, fpBottomMid, fpBottomRight, fpManual

    FormStyle* {.pure.} = enum
        fsNone, fsFixedSingle, fsFixed3D, fsFixedDialog, fsNormalWindow,
        fsFixedTool, fsSizableTool, fsHidden

    WindowState* {.pure.} = enum
        wsNormal, wsMaximized, wsMinimized

    FormDrawMode {.pure.} = enum
        fdmNormal, fdmFlat, fdmGradient

    FormGrad = object
        c1, c2 : Color
        rtl : bool

    Form* = ref object of Control
        hInstance: HINSTANCE
        mFormPos: FormPos
        mFormStyle: FormStyle
        mFormState: WindowState
        mFdMode: FormDrawMode
        # mContextMenu : ContextMenu
        mMaximizeBox, mMinimizeBox, mTopMost, mIsLoaded: bool
        mIsMouseTracking: bool
        mMenuGrayBrush, mMenuDefBgBrush, mMenuHotBgBrush, mMenuFrameBrush : HBRUSH
        mMenuFont : Font
        mMenuGrayCref : COLORREF
        mGrad : FormGrad
        mMenu: MenuBar
        tmpHwndSeq : seq[HWND]
        controls: seq[Control] #Table[Control, CreateFuncPtr]
        mMenuItemDict : Table[int32, MenuItem]
        mComboData: Table[HWND, HWND]

        #Events
        onLoad*, onActivate*, onDeActivate*, onMinimized*: EventHandler
        onMoving*, onMoved*, onClosing*: EventHandler
        onMaximized*, onRestored*: EventHandler
        onSizing*, onSized*: SizeEventHandler
        # onKeyDown*, onKeyUp*: KeyEventHandler
        # onKeyPress*: KeyPressEventHandler

    FlatDraw = object
        defBrush : HBRUSH
        hotBrush : HBRUSH
        defFrmBrush : HBRUSH
        hotFrmBrush : HBRUSH
        defPen: HPEN
        hotPen: HPEN
        isActive: bool

    GradColor = object
        c1: Color
        c2: Color

    GradDraw = object
        gcDef: GradColor
        gcHot: GradColor
        defPen: HPEN
        hotPen: HPEN
        rtl, isActive: bool

    Button* = ref object of Control
        mTxtFlag: UINT
        mFDraw: FlatDraw
        mGDraw: GradDraw

    WeekDays* {.pure.} = enum
        wdSunday = 1, wdMonday, wdTuesday, wdWednesday, wdThursday, wdFriday, wdSaturday

    DateAndTime* = object
        year*, month*, day*, hour*, minute*, second*, milliSecond*: int32
        dayOfWeek*: WeekDays

    ViewMode* {.pure.} = enum
        vmMonthView, vmYearView, vmDecadeView, vmCenturyView

    Calendar* = ref object of Control
        mValue: DateAndTime
        mShowWeekNum, mNoTodayCircle, mNoToday, mNoTrailDates, mShortDateNames: bool
        mViewMode, mOldView: ViewMode
        #Events
        onSelectionCommitted*, onValueChanged*, onViewChanged*: EventHandler

    CheckBox* = ref object of Control
        mAutoSize, mChecked, mRightAlign: bool
        mTextStyle: UINT
        #Events
        onCheckedChanged*: EventHandler

    ComboBox* = ref object of Control
        mSelIndex, mOwnCtlID: int32
        mReEnabled, mHasInput: bool
        mItems: seq[wstring]
        #Events
        onSelectionChanged*, onTextChanged*, onTextUpdated*: EventHandler
        onListOpened*, onListClosed*, onSelectionCommitted*, onSelectionCancelled*: EventHandler

    DTPFormat* {.pure.} = enum
        dfLongDate = 1, dfShortDate, dfTimeOnly = 4, dfCustom = 8

    DateTimePicker* = ref object of Control
        mFormat: DTPFormat
        mFmtStr: cstring
        mRightAlign, m4DYear, mShowWeekNum, mNoTodayCircle, mNoToday, mAutoSize: bool
        mNoTrailDates, mShortDateNames, mShowUpdown: bool
        mValue: DateAndTime
        mDropDownCount: int
        mCalStyle: DWORD
        # Events
        onValueChanged*, onCalendarOpened*, onCalendarClosed*: EventHandler
        onTextChanged*: DateTimeEventHandler

    GroupBox* = ref object of Control
        mTextWidth: int32
        mPen: HPEN
        mRect: RECT

    LabelBorder* {.pure.} = enum
        lbNone, lbSingle, lbSunken

    Label* = ref object of Control
        mAutoSize, mMultiLine: bool
        mTextAlign: TextAlignment
        mBorder: LabelBorder
        mAlignFlag: DWORD

    ListBox* = ref object of Control
        mHasSort, mNoSelection, mMultiColumn, mKeyPreview, mVertScroll, mHorizScroll, mMultiSel: bool
        mDummyIndex: int32
        mSelIndex: int32
        mSelIndices: seq[int32]
        mItems: seq[wstring]
        # Events
        onSelectionChanged*, onSelectionCancelled*: EventHandler

    ListViewItem* = ref object
        mText: wstring
        mIndex, mImgIndex: int32
        mBackColor, mForeColor: Color
        mFont: Font
        mLvHandle: HWND
        mColCount: int
        mItemID: int32
        mSubItems: seq[wstring]

    ListViewColumn* = ref object
        mText: wstring
        mWidth, mIndex, mImgIndex, mOrder: int32
        mImgOnRight, mHasImage, mDrawNeeded, mIsHotItem: bool
        mTextAlign, mHdrTextAlign: TextAlignment
        mBackColor, mForeColor: Color
        mHdrTextFlag: UINT
        mpLvc: LPLVCOLUMNW

    ListViewStyle* {.pure.} = enum
        lvsLargeIcon, lvsReport, lvsSmallIcon, lvsList, lvsTile

    ListView* = ref object of Control
        mSelIndex, mSelSubIndex, mHdrHeight: int32
        mColIndex, mRowIndex, mItemIndex, mLayoutCount: int32
        mEditLabel, mHideSel, mMultiSel, mHasCheckBox, mFullRowSel: bool
        mShowGrid, mOneClickActivate, mHotTrackSel, mNoHeader: bool
        mHdrClickable, mCheckBoxLast, mChecked, mChangeHdrHeight: bool
        mHdrBackColor, mHdrForeColor: Color
        mHdrHotBrush, mHdrBkBrush: HBRUSH
        mHdrFont: Font
        mHdrPen: HPEN
        mHotHdrIndex: DWORD_PTR
        mHdrHandle: HWND
        mSelItem: ListViewItem
        mViewStyle: ListViewStyle
        mColumns: seq[ListViewColumn]
        mItems: seq[ListViewItem]
        #Events
        onCheckedChanged*, onSelectionChanged*, onItemDoubleClicked*: EventHandler
        onItemClicked*, onItemHover*: EventHandler

    MenuType* {.pure.} = enum
        mtBaseMenu, mtMenuItem, mtPopup, mtSeparator, mtMenubar, mtContextMenu, mtContextSep

    MenuBar* = ref object # Implemented in commons.nim
        mHmenubar : HMENU
        mFont : Font
        mParent : Form
        mType : MenuType
        mMenuCount: int32
        mMenus : Table[int32, MenuItem]

    MenuItem* = ref object
        mIsCreated, mIsEnabled, mPopup, mFormMenu : bool
        mId, mChildCount, mIndex : int32
        mFont : Font
        mWideText: LPCWSTR # For drawing make fast
        mBgColor, mFgColor: Color
        mHmenu, mParentHmenu: HMENU
        mText : wstring
        mType : MenuType
        mFormHwnd : HWND
        mMenus : Table[int32, MenuItem]
        # Events
        onClick, onPopup, onCollapse, onFocus : MenuEventHandler

    ContextMenu* = ref object
        mHmenu : HMENU
        mFont : Font
        mWidth, mHeight, mMenuCount : int32
        mRightClick: bool
        mGrayCref : COLORREF
        mDummyHwnd : HWND
        mParent: Control
        mDefBgBrush, mHotBgBrush, mBorderBrush, mGrayBrush : HBRUSH
        mMenus : seq[MenuItem]
        # Events
        onMenuShown*, onMenuClose* : ContextMenuEventHandler

    NumberPicker* = ref object of Control
        mButtonLeft, mHasSeperator, mAutoRotate, mHideCaret: bool
        mValue, mMinRange, mMaxRange, mStep: float
        mTrackMLeave, mKeyPressed, mTrackMouseLeave, mIntStep: bool
        mBuddyStyle, mBuddyExStyle, mTxtFlag: DWORD
        mDeciPrec, mBuddyCID, mLineX: int32
        mBuddyRect, mUpdRect, mMyRect: RECT
        mTopEdgeFlag, mBotEdgeFlag: UINT
        mTxtPos: TextAlignment
        mBuddyHandle: HWND
        mPen: HPEN
        mBuddySCID: UINT_PTR
        mBuddyStr: wstring
        #Event
        onValueChanged*: EventHandler

    ProgressBarState* {.pure.} = enum
        pbsNone, pbsNormal, pbsError, pbsPaused

    ProgressBarStyle* {.pure.} = enum
        pbsBlock, pbsMarquee

    ProgressBar* = ref object of Control
        mBarState: ProgressBarState
        mBarStyle: ProgressBarStyle
        mVertical, mShowPerc: bool
        mMinValue, mMaxValue, mStep, mValue, mMarqueeSpeed: int32
        # Events
        onProgressChanged*: EventHandler

    RadioButton* = ref object of Control
        mAutoSize, mChecked, mCheckOnClick, mRightAlign: bool
        mTxtFlag: UINT
        onCheckedChanged*: EventHandler

    TextCase* {.pure.} = enum
        tcNormal, tcLowerCase, tcUpperCase

    TextType* {.pure.} = enum
        ttNormal, ttNumberOnly, ttPasswordChar

    TextBox* = ref object of Control
        mTextAlign: TextAlignment
        mTextCase: TextCase
        mTextType: TextType
        mCueBanner: wstring
        mMultiLine, mHideSel, mReadOnly: bool
        #Events
        onTextChanged*: EventHandler

    ChannelStyle* {.pure.} = enum
        csClassic, csOutline

    TrackChange* {.pure.} = enum
        tcNone, tcArrowLow, tcArrowHigh, tcPageLow, tcPageHigh, tcMouseClick, tcMouseDrag

    TicPosition* {.pure.} = enum
        tpDownSide, tpUpSide, tpLeftSide, tpRightSide, tpBothSide

    TicDrawMode {.pure.} = enum
        tdmVertical, tdmHorizUpper, tdmHorizDown

    TicData = object
        phyPoint: int32
        logPoint: int32

    TrackBar* = ref object of Control
        mVertical, mReversed, mNoTics, mSelRange, mDefTics: bool
        mToolTip, mCustDraw, mFreeMove, mNoThumb: bool
        mTicWidth, mMinRange, mMaxRange, mFrequency, mPageSize: int32
        mLineSize, mTicLen, mValue, mThumbHalf, mP1, mP2, mTcCount: int32
        mTicColor, mChanColor, mSelColor: Color
        mChanRect, mThumbRect, mMyRect: RECT
        mChanPen, mTicPen: HPEN
        mChanStyle: ChannelStyle
        mTrackChange: TrackChange
        mTicPos: TicPosition
        mSelBrush: HBRUSH
        mChanFlag: UINT
        mTicList: seq[TicData]
        #Events
        onValueChanged*, onDragging*, onDragged*: EventHandler

    # NodeNotifyHandler = proc(tv: TreeView, parent: TreeNode, child: TreeNode, nop: NodeOps, pos: int32)
    TreeNode* = ref object
        mImgIndex, mSelImgIndex, mChildCount, mIndex, mNodeCount, mNodeID: int32
        mChecked, mIsCreated: bool
        mForeColor, mBackColor: Color
        mHandle: HTREEITEM
        mTreeHandle: HWND
        mParentNode: TreeNode
        mText: wstring
        # mNotifyHandler: NodeNotifyHandler
        mNodes: seq[TreeNode]

    NodeOps {.pure.} = enum
        noAddNode, noInsertNode, noAddChild, noInsertChild

    NodeNotify = ref object # Send data from a node to treeview
        node: TreeNode
        parent: TreeNode
        pos: int32
        nops: NodeOps

    NodeAction {.pure.} = enum
        naAddNode, naSetText, naForeColor, naBackColor

    NewNodeInfo = ref object
        node: TreeNode
        parent: TreeNode
        opMode: NodeOps
        position: int32

    TreeView* = ref object of Control
        mNoLine, mNoButton, mHasCheckBox, mFullRowSel: bool
        mEditable, mShowSel, mHotTrack, mNodeChecked: bool
        mNodeCount, mUniqNodeID: int32
        mLineColor: Color
        mSelNode: TreeNode
        newNodes: seq[NewNodeInfo]
        mNodes: seq[TreeNode]
        # Events
        onBeginEdit, onEndEdit, onNodeDeleted : EventHandler
        onBeforeChecked, onAfterChecked, onBeforeSelected: TreeEventHandler
        onAfterSelected, onBeforeExpanded, onAfterExpanded: TreeEventHandler
        onBeforeCollapsed, onAfterCollapsed: TreeEventHandler




