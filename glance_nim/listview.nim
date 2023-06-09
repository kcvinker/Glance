# listview module Created on 01-Apr-2023 11:22 PM; Author kcvinker[Added to Glance on 02-Jun-2023 10:21]
# ListView type
#   constructor - newListView*(parent: Form, x, y: int32 = 10, w: int32 = 250, h: int32 = 200): ListView
#   functions
        # createHandle() - Create the handle of listView
        # addColumn*(text: string, width: int32, imgIndex: int32 = -1): ListViewColumn {.discardable.}
        # addColumns*(colNames: seq[string], colWidths: seq[auto]): seq[ListViewColumn] {.discardable.}
        # addColumns*(colCount: int, nameAndWidth: varargs[string, `$`]): seq[ListViewColumn] {.discardable.}
        # addItem*(itemTxt: auto, bgColor: uint = 0xFFFFFF, fgColor: uint = 0x000000, imgIndex: int32 = -1) : ListViewItem {.discardable.}
        # addItem*(item: ListViewItem)
        # addItems*(items: varargs[ListViewItem])
        # addItems*(itemTextList: varargs[string, `$`]) : seq[ListViewItem] {.discardable.}
        # addRow*(items: varargs[string, `$`]) : ListViewItem {.discardable.}
        # addSubItem*(subitem: auto, subIndx: int32, imgIndex: int32 = -1)
        # addSubItems*(subitems: varargs[string, `$`])

#     Properties - Getter & Setter available
#       Name                Type
        # font              Font
        # text              string
        # width             int32
        # height            int32
        # xpos              int32
        # ypos              int32
        # backColor         Color
        # foreColor         Color

        # headerHeight      int32
        # editLabel         bool
        # hideSelection     bool
        # multiSelection    bool
        # hasCheckBox       bool
        # fullRowSelection  bool
        # showGrid          bool
        # oneClickActivate  bool
        # hotTrackSelection bool
        # headerClickable   bool
        # checkBoxLast      bool
        # headerBackColor   Getter - Color, Setter - [Color, uint]
        # headerForeColor   Getter - Color, Setter - [Color, uint]
        # headerFont        Font
        # selectedItem      ListViewItem
        # viewStyle         ListViewStyle {lvsLargeIcon, lvsReport, lvsSmallIcon, lvsList, lvsTile}

        # Getter only------------
        # selectedIndex         int32
        # selectedSubIndex      int32
        # checked               bool
        # columns               seq[ListViewColumn]
        # items                 seq[ListViewItem]

    # Events
    #     onMouseEnter*, onClick*, onMouseLeave*, onRightClick*, onDoubleClick*,
    #     onLostFocus*, onGotFocus*: EventHandler - proc(c: Control, e: EventArgs)

    #     onMouseWheel*, onMouseHover*, onMouseMove*, onMouseDown*, onMouseUp*
    #     onRightMouseDown*, onRightMouseUp*: MouseEventHandler - - proc(c: Control, e: MouseEventArgs)

    #     onCheckedChanged*, onSelectionChanged*, onItemDoubleClicked*,
    #     onItemClicked*, onItemHover*: EventHandler
#---------------------------------------------------------------------------------------

# ListViewColumn type
    # constructor - newListViewColumn*(text: string, width: int32, imgIndex: int32 = -1) : ListViewColumn

    # Properties
    # Name                  Type
    # index                 int32
    # text                  string
    # width                 int32
    # imageIndex            int32
    # imageOnRight          bool
    # hasImage              bool
    # textAlign             TextAlignment - {taLeft, taCenter, taRight}
    # headerTextAlign       TextAlignment
    # backColor             Color (Use uint also for setter)
    # foreColor             Color (Use uint also for setter)

#-------------------------------------------------------------------------------------------

# ListViewItem type
    # Constructor - newListViewItem*(text: string, bgColor: uint = 0xFFFFFF, fgColor: uint = 0x000000, imgIndex: int32 = -1): ListViewItem

    # Properties
    # Name              Type
    # index             int32 (Getter only)
    # subItems          seq[string (Getter only)
    # text              string
    # imageIndex        int32
    # backColor         Color (Use uint also for setter)
    # foreColor         Color (Use uint also for setter)
    # font              Font


# Note: Improve some properties to respond at runtime
# Constants
const
    LVM_FIRST = 0x1000
    LVN_FIRST = cast[UINT](0-100)
    LVS_ICON = 0x0000
    LVS_REPORT = 0x0001
    LVS_SMALLICON = 0x0002
    LVS_LIST = 0x0003
    LVS_SHOWSELALWAYS = 0x0008
    LVS_EDITLABELS = 0x0200
    LVS_ALIGNLEFT = 0x0800
    LVS_NOCOLUMNHEADER = 0x4000
    LVS_SINGLESEL = 0x0004
    LVS_EX_GRIDLINES = 0x00000001
    LVS_EX_CHECKBOXES = 0x00000004
    LVS_EX_TRACKSELECT = 0x00000008
    LVS_EX_FULLROWSELECT = 0x00000020
    LVS_EX_ONECLICKACTIVATE = 0x00000040
    LV_VIEW_ICON = 0x0000
    LV_VIEW_DETAILS  = 0x0001
    LV_VIEW_SMALLICON = 0x0002
    LV_VIEW_LIST = 0x0003
    LV_VIEW_TILE = 0x0004
    LV_VIEW_MAX = 0x0004
    LVCF_FMT = 1
    LVCF_WIDTH = 2
    LVCF_TEXT = 4
    LVCF_SUBITEM = 8
    LVCF_IMAGE = 16
    LVCF_ORDER = 32
    LVCFMT_LEFT = 0
    LVCFMT_RIGHT = 1
    LVCFMT_CENTER = 2
    LVCFMT_JUSTIFYMASK = 3
    LVCFMT_IMAGE = 2048
    LVCFMT_BITMAP_ON_RIGHT = 4096
    LVCFMT_COL_HAS_IMAGES = 32768
    LVIF_TEXT = 1
    LVIF_IMAGE = 2
    LVIF_PARAM = 4
    LVIF_STATE = 8
    LVM_SETBKCOLOR = (LVM_FIRST + 1)
    LVM_GETHEADER = (LVM_FIRST + 31)
    LVM_SETEXTENDEDLISTVIEWSTYLE = (LVM_FIRST + 54)
    LVM_SETCOLUMNORDERARRAY = (LVM_FIRST + 58)
    LVM_INSERTITEMW = (LVM_FIRST + 77)
    LVM_INSERTCOLUMNW = (LVM_FIRST + 97)
    LVM_SETITEMTEXTW = (LVM_FIRST + 116)
    LVN_ITEMCHANGED = (LVN_FIRST-1)

var lvCount = 1
var gItemId : int32 = 1
let wHundred = toWstring("100")
let LVSTYLE: DWORD = WS_VISIBLE or WS_CHILD or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or LVS_REPORT or WS_BORDER or LVS_ALIGNLEFT or LVS_SINGLESEL
# Forward declaration
proc lvWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.}
proc hdrWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.}

# ListView constructor
proc newListView*(parent: Form, x, y, w, h: int32): ListView {.exportc:"newListView", stdcall, dynlib.} =
    new(result)
    result.mKind = ctListView
    result.mClassName = "SysListView32"
    result.mName = "ListView_" & $lvCount
    result.mParent = parent
    result.mXpos = x
    result.mYpos = y
    result.mWidth = w
    result.mHeight = h
    result.mFont = parent.mFont
    result.mBackColor = CLR_WHITE
    result.mForeColor = CLR_BLACK
    result.mStyle = LVSTYLE
    result.mExStyle = 0
    result.mViewStyle = lvsReport
    result.mShowGrid = true
    result.mFullRowSel = true
    result.mHideSel = true
    result.mOneClickActivate = true
    result.mHdrClickable = true
    result.mHdrHeight = 35
    result.mItemIndex = -1
    result.mHotHdrIndex = cast[DWORD_PTR](-1)
    result.mHdrBackColor = newColor(0xdce1de)
    result.mHdrForeColor = CLR_BLACK
    result.mHdrFont = result.mFont
    result.mParent.controls.add(result)
    result.mCtlID = globalCtlID
    globalCtlID += 1
    lvCount += 1


proc newListViewColumn*(text: wstring, width: int32, imgIndex: int32 = -1) : ListViewColumn {.exportc:"newListViewColumn", stdcall, dynlib.} =
    new(result)
    result.mText = text
    result.mWidth = width
    result.mImgIndex = imgIndex
    result.mImgOnRight = false
    result.mTextAlign = taLeft
    result.mIndex = -1
    result.mHdrTextAlign = taCenter
    result.mHdrTextFlag = DT_SINGLELINE or DT_VCENTER or DT_CENTER or DT_NOPREFIX


proc newListViewItem*(text: wstring, bgColor: uint = 0xFFFFFF, fgColor: uint = 0x000000,
                        imgIndex: int32 = -1): ListViewItem {.exportc:"newListViewItem", stdcall, dynlib.} =
    new(result)
    result.mText = text
    result.mBackColor = newColor(bgColor)
    result.mForeColor = newColor(fgColor)
    result.mIndex = -1
    result.mImgIndex = imgIndex
    result.mItemID = gItemId # We need this id to identify items from autoit world.
    gItemId += 1


proc setLVStyle(this: ListView) =
    case this.mViewStyle
    of lvsLargeIcon: this.mStyle = this.mStyle or LVS_ICON
    of lvsReport: this.mStyle = this.mStyle or LVS_REPORT
    of lvsSmallIcon: this.mStyle = this.mStyle or LVS_SMALLICON
    of lvsList: this.mStyle = this.mStyle or LVS_LIST
    else: discard

    if this.mEditLabel: this.mStyle = this.mStyle or LVS_EDITLABELS
    if this.mNoHeader: this.mStyle = this.mStyle or LVS_NOCOLUMNHEADER
    if this.mHideSel: this.mStyle = this.mStyle xor LVS_SHOWSELALWAYS
    if this.mMultiSel: this.mStyle = this.mStyle xor LVS_SINGLESEL
    # Set some brushes & pen
    this.mHdrBkBrush = CreateSolidBrush(this.mHdrBackColor.cref)
    this.mHdrHotBrush = this.mHdrBackColor.getHotBrush(0.9)
    this.mHdrPen = CreatePen(PS_SOLID, 1, 0x00FFFFFF) # A white pen


proc setLVExStyles(this: ListView) =
    var lvExStyle: DWORD = 0x0000
    if this.mShowGrid: lvExStyle = lvExStyle or LVS_EX_GRIDLINES
    if this.mHasCheckBox: lvExStyle = lvExStyle or LVS_EX_CHECKBOXES
    if this.mFullRowSel: lvExStyle = lvExStyle or LVS_EX_FULLROWSELECT
    if this.mOneClickActivate: lvExStyle = lvExStyle or LVS_EX_ONECLICKACTIVATE
    if this.mHotTrackSel: lvExStyle = lvExStyle or LVS_EX_TRACKSELECT
    # if (this.viewStyle == ListViewStyle.TileView: SendMessageW(this.handle, LVM_SETVIEW, 0x0004, 0)
    this.sendMsg(LVM_SETEXTENDEDLISTVIEWSTYLE, 0, lvExStyle)

proc setHeaderSubclass(this: ListView) {.inline.} =
    this.mHdrHandle = cast[HWND](this.sendMsg(LVM_GETHEADER, 0, 0))
    SetWindowSubclass(this.mHdrHandle, hdrWndProc, globalSubClassID, cast[DWORD_PTR](cast[PVOID](this)))
    globalSubClassID += 1



proc addColumnInternal(this: ListView, lvCol: ListViewColumn, bFlag: bool = true) =
    lvCol.mIndex = this.mColIndex
    var lvc: LVCOLUMNW
    lvc.mask = LVCF_FMT or LVCF_TEXT  or LVCF_WIDTH  or LVCF_SUBITEM #-or LVCF_ORDER
    lvc.fmt = int32(lvCol.mTextAlign)
    lvc.cx = lvCol.mWidth
    lvc.pszText = lvCol.mText[0].unsafeAddr
    if lvCol.mHasImage:
        lvc.mask = lvc.mask or LVCF_IMAGE
        lvc.fmt = lvc.fmt or LVCFMT_COL_HAS_IMAGES or LVCFMT_IMAGE
        lvc.iImage = lvCol.mImgIndex
        if lvCol.mImgOnRight: lvc.fmt = lvc.fmt or LVCFMT_BITMAP_ON_RIGHT

    lvCol.mpLvc = lvc.unsafeAddr
    if bFlag:
        this.mColumns.add(lvCol)
        this.mColIndex += 1
    if this.mIsCreated:
        this.sendMsg(LVM_INSERTCOLUMNW, lvCol.mIndex, lvc.unsafeAddr)

    # We need this to do the painting in wm notify.
    # if (!this.mDrawColumns && lvCol.mDrawNeeded) this.mDrawColumns = true


# proc addIfAnySubItems(this: ListView, item: ListViewItem) =
#     if item.mSubItems.len > 0:
#         var subIndex: int32 = 1
#         for subitem in item.mSubItems:
#             this.addSubItemInternal(subitem[0].unsafeAddr, item.mIndex, subIndex, -1, false)


proc addItemInternal(this: ListView, item: ListViewItem, bFlag: bool = true) =
    if this.mIsCreated:
        item.mColCount = this.mColumns.len
        item.mLvHandle = this.mHandle
        var lvi: LVITEMW
        lvi.mask = LVIF_TEXT or LVIF_PARAM or LVIF_STATE
        if item.mImgIndex != -1: lvi.mask = lvi.mask or LVIF_IMAGE
        lvi.state = 0
        lvi.stateMask = 0
        lvi.iItem = item.mIndex
        lvi.iSubItem = 0
        lvi.iImage = item.mImgIndex
        lvi.pszText = item.mText[0].addr
        lvi.cchTextMax = int32(item.mText.len)
        lvi.lParam = cast[LPARAM](cast[PVOID](item))
        this.sendMsg(LVM_INSERTITEMW, 0, lvi.addr)
        if bFlag:
            this.mItems.add(item)
            this.mRowIndex += 1

        if item.mSubItems.len > 0:
            for i, subitm in item.mSubItems:
                var lw: LVITEMW
                lw.iSubItem = int32(i + 1)
                lw.pszText = subitm[0].unsafeAddr
                lw.iImage = -1
                this.sendMsg(LVM_SETITEMTEXTW, item.mIndex, lw.addr)

    else:
        this.mItems.add(item)

proc addSubItemInternal(this: ListView, subItmTxt: LPCWSTR, itemIndex: int32, subIndx: int32, imgIndex: int32 = -1) =
    var lw: LVITEMW
    lw.iSubItem = subIndx
    lw.pszText = subItmTxt
    lw.iImage = imgIndex
    this.sendMsg(LVM_SETITEMTEXTW, itemIndex, lw.addr)
    # if addToList: this.mItems[itemIndex].mSubItems.add(subItmTxt)

proc postCreationTasks(this: ListView) =
    if this.mBackColor.value != CLR_WHITE.value: this.sendMsg(LVM_SETBKCOLOR, 0, this.mBackColor.cref)
    if this.mCheckBoxLast and this.mColumns.len > 0:
        var iSeq: seq[int32] = newSeq[int32](this.mColumns.len)
        for col in this.mColumns:
            if col.mIndex > 0: iSeq.add(col.mIndex)
        iSeq.add(0)
        this.sendMsg(LVM_SETCOLUMNORDERARRAY, int32(iSeq.len), iSeq[0].unsafeAddr)
    if this.mColumns.len > 0:
        for col in this.mColumns:
            this.addColumnInternal(col, false)

    if this.mItems.len > 0:
        for item in this.mItems:
            this.addItemInternal(item, false)
            # this.addIfAnySubItems(item)

proc headerCustomDraw(this: ListView, nmcd: LPNMCUSTOMDRAW): LRESULT =
    # When Windows paints the listview header, it sends us a notification.
    # So we can use that notification and draw our headers.
    let col = this.mColumns[nmcd.dwItemSpec]
    SetBkMode(nmcd.hdc, 1)
    if col.mIndex > 0: nmcd.rc.left = nmcd.rc.left + 1
    if this.mHdrClickable:
        if (nmcd.uItemState and CDIS_SELECTED) == CDIS_SELECTED:
            # Header is clicked. So we will change the back color.
            FillRect(nmcd.hdc, nmcd.rc.unsafeAddr, this.mHdrBkBrush)
        else:
            if nmcd.dwItemSpec == this.mHotHdrIndex:
                # Mouse pointer is on header. So we will change the back color.
                FillRect(nmcd.hdc, nmcd.rc.unsafeAddr, this.mHdrHotBrush)
            else:
                FillRect(nmcd.hdc, nmcd.rc.unsafeAddr, this.mHdrBkBrush)

        if (nmcd.uItemState and CDIS_SELECTED) == CDIS_SELECTED:
            # Mimicing dot net's technique. Adjusting rect to get the feel of clicked button.
            nmcd.rc.left = nmcd.rc.left + 2
            nmcd.rc.top = nmcd.rc.top + 2

    else:
        FillRect(nmcd.hdc, nmcd.rc.unsafeAddr, this.mHdrBkBrush)

    # Draw a white line on ther right side of the hdr
    SelectObject(nmcd.hdc, this.mHdrPen)
    MoveToEx(nmcd.hdc, nmcd.rc.right, nmcd.rc.top, nil)
    LineTo(nmcd.hdc, nmcd.rc.right, nmcd.rc.bottom)
    SelectObject(nmcd.hdc, this.mHdrFont.handle)
    SetTextColor(nmcd.hdc, this.mHdrForeColor.cref)
    DrawTextW(nmcd.hdc, col.mText[0].unsafeAddr, int32(-1), nmcd.rc.unsafeAddr, col.mHdrTextFlag)
    result = CDRF_SKIPDEFAULT

proc destroyResources(this: ListView) =
    if this.mHdrHotBrush != nil: DeleteObject(this.mHdrHotBrush)
    if this.mHdrBkBrush != nil: DeleteObject(this.mHdrBkBrush)
    if this.mHdrFont.handle != nil: DeleteObject(this.mHdrFont.handle)
    if this.mHdrPen != nil: DeleteObject(this.mHdrPen)
    this.destructor()

# Create ListView's hwnd
method createHandle*(this: ListView) =
    this.setLVStyle()
    this.createHandleInternal()
    if this.mHandle != nil:
        this.setLVExStyles()
        this.setSubclass(lvWndProc)
        this.setHeaderSubclass()
        this.setFontInternal()
        this.postCreationTasks()

#---------------------Add Column variants----------------------------------------------------

proc addColumn*(this: ListView, text: LPCWSTR, width: int32,
                imgIndex: int32 = -1) {.exportc:"lvAddColumn", stdcall, dynlib.} =
    var col = newListViewColumn(toWstring(text), width, imgIndex)
    this.addColumnInternal(col)


proc addColumns*(this: ListView, colNames: LPCWSTR, colWidths: LPSTR){.exportc:"lvAddColumns", stdcall, dynlib.} =
    var wColnames = toWstring(colNames)
    var uColWidths = toUtf8String(colWidths)
    var namesSeq = splitWstring(wColnames, pipeChar)
    var widthSeq : seq[int]
    if uColWidths == "0":
        for _ in namesSeq: widthSeq.add(100)
    else:
        widthSeq = split(uColWidths, '|').map(parseInt)

    if namesSeq.len != widthSeq.len: raise newException(ValueError, "Column widths are not equal to column names")
    for i, name in namesSeq:
        var col = newListViewColumn(name, int32(widthSeq[i]))
        this.addColumnInternal(col)

#-------------Add Item variants------------------------------------------------------

proc addItem*(this: ListView, itemTxt: LPCWSTR, bgColor: uint = 0xFFFFFF, fgColor: uint = 0x000000,
                imgIndex: int32 = -1) : ListViewItem {.exportc:"lvAddItem1", stdcall, dynlib, discardable.} =
    result = newListViewItem(toWstring(itemTxt), bgColor, fgColor, imgIndex)
    result.mIndex = this.mRowIndex
    this.mRowIndex += 1
    this.addItemInternal(result)


proc addItem*(this: ListView, item: ListViewItem) {.exportc:"lvAddItem2", stdcall, dynlib.} =
    item.mIndex = this.mRowIndex
    this.mRowIndex += 1
    this.addItemInternal(item)

proc addLvSubItem(item: ListViewItem, subitm: LPCWSTR) {.exportc:"lvAddSubitem1", stdcall, dynlib.} =
    item.mSubItems.add(toWstring(subitm))

proc addLvSubItem(this: ListView, itemIndex: int32, subitm: LPCWSTR) {.exportc:"lvAddSubitem2", stdcall, dynlib.} =
    if itemIndex < this.mItems.len:
        this.mItems[itemIndex].mSubItems.add(toWstring(subitm))
    # var sitem : wstring
    # if subitm is LPCWSTR:
    #     sitem = toWstring(subitm)
    # else:
    #     sitem = toWstring($subitm)



# proc addItems*(this: ListView, itemTextList: varargs[string, `$`]) : seq[ListViewItem] {.discardable.} =
#     for txt in itemTextList:
#         var item = newListViewItem(txt)
#         this.addItemInternal(item)
#         result.add(item)

proc addRow*(this: ListView, items: LPCWSTR) {.exportc:"lvAddRow", stdcall, dynlib.}  =
    if this.mViewStyle != lvsReport: raise newException(Exception, "Only works for Report view style.")
    var rowTxt = toWstring(items)
    var rowSeq = splitWstring(rowTxt, pipeChar)
    if rowSeq.len == this.mColumns.len:
        var lvitem = newListViewItem(rowSeq[0])
        lvitem.mIndex = this.mRowIndex
        this.mRowIndex += 1
        for i, item in rowSeq:
            if i == 0: continue
            lvitem.mSubItems.add(rowSeq[i])
        this.addItemInternal(lvitem)


    else:
        raise newException(Exception, "Items count is not matching to column count.")

#--------------Add SubItems variants---------------------------------------------------------------------

proc addSubItem*(this: ListViewItem, subitem: LPWSTR, subIndx: int32,
                    imgIndex: int32 = -1) {.exportc:"listViewAddSubItem", stdcall, dynlib.} =
    let sitem : wstring = toWstring(subitem)
    var lw: LVITEMW
    lw.iSubItem = subIndx
    lw.pszText = sitem[0].unsafeAddr
    lw.iImage = imgIndex
    SendMessageW(this.mLvHandle, LVM_SETITEMTEXTW, WPARAM(this.mIndex), cast[LPARAM](lw.unsafeAddr))
    this.mSubItems.add(sitem)

proc setHeaderFont(this: ListView, fname: LPCWSTR, fsize: int32, fweight: int32 = int32(fwNormal)) {.
                        exportc:"listViewSetHeaderFont", stdcall, dynlib.} =
    var fontName = toWstring(fname)
    let weight = cast[FontWeight](fweight)
    var hdrFont = newFont(fontName, fsize, weight)
    let whandle = if this.mIsCreated: this.mHdrHandle else: this.mParent.mHandle
    hdrFont.createHandle(whandle)
    this.mHdrFont = hdrFont
    if this.mIsCreated: InvalidateRect(this.mHandle, nil, 0)

# proc addSubItems*(this: ListViewItem, subitems: varargs[string, `$`]) =
#     if (subitems.len + 1) != this.mColCount: raise newException(Exception, "Column count is not matching to sub item count")
#     for index, subitem in subitems:
#         let sitem : string = (if subitem is string: subitem else: $subitem)
#         var lw: LVITEMW
#         lw.iSubItem = int32(index + 1)
#         lw.pszText = sitem.toLPWSTR()
#         lw.iImage = -1
#         SendMessageW(this.mLvHandle, LVM_SETITEMTEXTW, WPARAM(this.mIndex), cast[LPARAM](lw.unsafeAddr))
#         this.mSubItems.add(sitem)


# Properties---------------------------------------------------------------------------
proc selectedIndex*(this: ListView): int32 {.inline.} = this.mSelIndex
proc selectedSubIndex*(this: ListView): int32 {.inline.} = this.mSelSubIndex
proc checked*(this: ListView): bool {.inline.} = this.mChecked
proc columns*(this: ListView): seq[ListViewColumn] {.inline.} = this.mColumns
proc items*(this: ListView): seq[ListViewItem] {.inline.} = this.mItems

proc `headerHeight=`*(this: ListView, value : int32) {.inline.} =
    this.mHdrHeight = value
    this.mChangeHdrHeight = true
proc headerHeight*(this: ListView): int32 {.inline.} = this.mHdrHeight

proc `editLabel=`*(this: ListView, value: bool) {.inline.} = this.mEditLabel = value
proc editLabel*(this: ListView): bool {.inline.} = this.mEditLabel

proc `hideSelection=`*(this: ListView, value: bool) {.inline.} = this.mHideSel = value
proc hideSelection*(this: ListView): bool {.inline.} = this.mHideSel

proc `multiSelection=`*(this: ListView, value: bool) {.inline.} = this.mMultiSel = value
proc multiSelection*(this: ListView): bool {.inline.} = this.mMultiSel

proc `hasCheckBox=`*(this: ListView, value: bool) {.inline.} = this.mHasCheckBox = value
proc hasCheckBox*(this: ListView): bool {.inline.} = this.mHasCheckBox

proc `fullRowSelection=`*(this: ListView, value: bool) {.inline.} = this.mFullRowSel = value
proc fullRowSelection*(this: ListView): bool {.inline.} = this.mFullRowSel

proc `showGrid=`*(this: ListView, value: bool) {.inline.} = this.mShowGrid = value
proc showGrid*(this: ListView): bool {.inline.} = this.mShowGrid

proc `oneClickActivate=`*(this: ListView, value: bool) {.inline.} = this.mOneClickActivate = value
proc oneClickActivate*(this: ListView): bool {.inline.} = this.mOneClickActivate

proc `hotTrackSelection=`*(this: ListView, value: bool) {.inline.} = this.mHotTrackSel = value
proc hotTrackSelection*(this: ListView): bool {.inline.} = this.mHotTrackSel

proc `headerClickable=`*(this: ListView, value: bool) {.inline.} = this.mHdrClickable = value
proc headerClickable*(this: ListView): bool {.inline.} = this.mHdrClickable

proc `checkBoxLast=`*(this: ListView, value: bool) {.inline.} = this.mCheckBoxLast = value
proc checkBoxLast*(this: ListView): bool {.inline.} = this.mCheckBoxLast

proc `headerBackColor=`*(this: ListView, value: uint) {.inline.} = this.mHdrBackColor = newColor(value)
proc `headerBackColor=`*(this: ListView, value: Color) {.inline.} = this.mHdrBackColor = value
proc headerBackColor*(this: ListView): Color {.inline.} = this.mHdrBackColor

proc `headerForeColor=`*(this: ListView, value: uint) {.inline.} = this.mHdrForeColor = newColor(value)
proc `headerForeColor=`*(this: ListView, value: Color) {.inline.} = this.mHdrForeColor = value
proc headerForeColor*(this: ListView): Color {.inline.} = this.mHdrForeColor

proc `headerFont=`*(this: ListView, value: Font) {.inline.} = this.mHdrFont = value
proc headerFont*(this: ListView): Font {.inline.} = this.mHdrFont

proc `selectedItem=`*(this: ListView, value: ListViewItem) {.inline.} = this.mSelItem = value
proc selectedItem*(this: ListView): ListViewItem {.inline.} = this.mSelItem

proc `viewStyle=`*(this: ListView, value: ListViewStyle) {.inline.} = this.mViewStyle = value
proc viewStyle*(this: ListView): ListViewStyle {.inline.} = this.mViewStyle

#-----------ListViewColumn properties------------------------------------

proc index*(this: ListViewColumn): int32 {.inline.} = this.mIndex

proc `text=`*(this: ListViewColumn, value: LPCWSTR) {.inline.} = this.mText = toWstring(value)
proc text*(this: ListViewColumn): LPCWSTR {.inline.} = this.mText[0].unsafeAddr

proc `width=`*(this: ListViewColumn, value: int32) {.inline.} = this.mWidth = value
proc width*(this: ListViewColumn): int32 {.inline.} = this.mWidth

proc `imageIndex=`*(this: ListViewColumn, value: int32) {.inline.} = this.mImgIndex = value
proc imageIndex*(this: ListViewColumn): int32 {.inline.} = this.mImgIndex

proc `imageOnRight=`*(this: ListViewColumn, value: bool) {.inline.} = this.mImgOnRight = value
proc imageOnRight*(this: ListViewColumn): bool {.inline.} = this.mImgOnRight

proc `hasImage=`*(this: ListViewColumn, value: bool) {.inline.} = this.mHasImage = value
proc hasImage*(this: ListViewColumn): bool {.inline.} = this.mHasImage

proc `textAlign=`*(this: ListViewColumn, value: TextAlignment) {.inline.} = this.mTextAlign = value
proc textAlign*(this: ListViewColumn): TextAlignment {.inline.} = this.mTextAlign

proc `headerTextAlign=`*(this: ListViewColumn, value: TextAlignment) {.inline.} = this.mHdrTextAlign = value
proc headerTextAlign*(this: ListViewColumn): TextAlignment {.inline.} = this.mHdrTextAlign

proc `backColor=`*(this: ListViewColumn, value: uint) {.inline.} = this.mBackColor = newColor(value)
proc `backColor=`*(this: ListViewColumn, value: Color) {.inline.} = this.mBackColor = value
proc backColor*(this: ListViewColumn): Color {.inline.} = this.mBackColor

proc `foreColor=`*(this: ListViewColumn, value: uint) {.inline.} = this.mForeColor = newColor(value)
proc `foreColor=`*(this: ListViewColumn, value: Color) {.inline.} = this.mForeColor = value
proc foreColor*(this: ListViewColumn): Color {.inline.} = this.mForeColor

#------ListViewItem properties------------------------------------------------------------

proc index*(this: ListViewItem): int32 {.inline.} = this.mIndex
proc subItems*(this: ListViewItem): seq[wstring] {.inline.} = this.mSubItems

proc `text=`*(this: ListViewItem, value: LPCWSTR) {.inline.} = this.mText = toWstring(value)
proc text*(this: ListViewItem): LPCWSTR {.inline.} = this.mText[0].unsafeAddr

proc `imageIndex=`*(this: ListViewItem, value: int32) {.inline.} = this.mImgIndex = value
proc imageIndex*(this: ListViewItem): int32 {.inline.} = this.mImgIndex

proc `backColor=`*(this: ListViewItem, value: uint) {.inline.} = this.mBackColor = newColor(value)
proc `backColor=`*(this: ListViewItem, value: Color) {.inline.} = this.mBackColor = value
proc backColor*(this: ListViewItem): Color {.inline.} = this.mBackColor

proc `foreColor=`*(this: ListViewItem, value: uint) {.inline.} = this.mForeColor = newColor(value)
proc `foreColor=`*(this: ListViewItem, value: Color) {.inline.} = this.mForeColor = value
proc foreColor*(this: ListViewItem): Color {.inline.} = this.mForeColor

proc `font=`*(this: ListViewItem, value: Font) {.inline.} = this.mFont = value
proc font*(this: ListViewItem): Font {.inline.} = this.mFont


proc setListViewEvents(this: ListView, evtIndex: ListViewEvents, funcPtr: EventHandler) =
    case evtIndex
    of lvCheckedChanged: this.onCheckedChanged = funcPtr
    of lvSelectionChanged : this.onSelectionChanged = funcPtr
    of lvItemDoubleClicked : this.onItemDoubleClicked = funcPtr
    of lvItemClicked: this.onItemClicked = funcPtr
    of lvItemHover: this.onItemHover = funcPtr

proc setListViewProps(this: ListView, prop: ListViewProps, value: pointer) =
    case prop
    of lvSelectedIndex: discard #this.selectedIndex = cast[ref int32](value)[]
    of lvSelectedSubIndex: discard # this.selectedSubIndex = cast[ref int32](value)[]
    of lvHeaderHeight: this.headerHeight = cast[ref int32](value)[]
    of lvEditLabel: this.editLabel = cast[bool](cast[ref int](value)[])
    of lvHideSelection: this.hideSelection = cast[bool](cast[ref int](value)[])
    of lvMultiSelection: this.multiSelection = cast[bool](cast[ref int](value)[])
    of lvHasCheckBox: this.hasCheckBox = cast[bool](cast[ref int](value)[])
    of lvFullRowSelection: this.fullRowSelection = cast[bool](cast[ref int](value)[])
    of lvShowGrid: this.showGrid = cast[bool](cast[ref int](value)[])
    of lvOneClickActivate: this.oneClickActivate = cast[bool](cast[ref int](value)[])
    of lvHotTrackSelection: this.hotTrackSelection = cast[bool](cast[ref int](value)[])
    of lvHeaderClickable: this.headerClickable = cast[bool](cast[ref int](value)[])
    of lvChecked: discard # this.checked = cast[bool](cast[ref int](value)[])
    of lvCheckBoxLast: this.checkBoxLast = cast[bool](cast[ref int](value)[])
    of lvViewStyle: this.viewStyle = cast[ListViewStyle](cast[ref int](value)[])
    of lvHeaderBackColor: this.headerBackColor = cast[ref uint](value)[]
    of lvHeaderForeColor: this.headerForeColor = cast[ref uint](value)[]
    of lvSelectedItem: this.selectedItem = cast[ListViewItem](value)

proc getListViewProps(this: ListView, prop: ListViewProps, value: pointer) =
    case prop
    of lvSelectedIndex: cast[ref int32](value)[] = this.selectedIndex
    of lvSelectedSubIndex: cast[ref int32](value)[] = this.selectedSubIndex
    of lvHeaderHeight: cast[ref int](value)[] = this.headerHeight
    of lvEditLabel: cast[ref bool](value)[] = this.editLabel
    of lvHideSelection: cast[ref bool](value)[] = this.hideSelection
    of lvMultiSelection: cast[ref bool](value)[] = this.multiSelection
    of lvHasCheckBox: cast[ref bool](value)[] = this.hasCheckBox
    of lvFullRowSelection: cast[ref bool](value)[] = this.fullRowSelection
    of lvShowGrid: cast[ref bool](value)[] = this.showGrid
    of lvOneClickActivate: cast[ref bool](value)[] = this.oneClickActivate
    of lvHotTrackSelection: cast[ref bool](value)[] = this.hotTrackSelection
    of lvHeaderClickable: cast[ref bool](value)[] = this.headerClickable
    of lvChecked: cast[ref bool](value)[] = this.checked
    of lvCheckBoxLast: cast[ref bool](value)[] = this.checkBoxLast
    of lvViewStyle: cast[ref int](value)[] = int(this.viewStyle)
    of lvHeaderBackColor: cast[ref uint](value)[] = this.headerBackColor.value
    of lvHeaderForeColor: cast[ref uint](value)[] = this.headerForeColor.value
    of lvSelectedItem: cast[ref ListViewItem](value)[] = this.selectedItem



proc lvWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.} =
    var this = cast[ListView](refData)
    case msg
    of WM_DESTROY:
        this.destroyResources()
        RemoveWindowSubclass(hw, lvWndProc, scID)
    of WM_LBUTTONDOWN: this.leftButtonDownHandler(msg, wpm, lpm)
    of WM_LBUTTONUP: this.leftButtonUpHandler(msg, wpm, lpm)
    of WM_RBUTTONDOWN: this.rightButtonDownHandler(msg, wpm, lpm)
    of WM_RBUTTONUP: this.rightButtonUpHandler(msg, wpm, lpm)
    of WM_MOUSEMOVE: this.mouseMoveHandler(msg, wpm, lpm)
    of WM_MOUSELEAVE: this.mouseLeaveHandler()

    of WM_PAINT: return this.paintHandler(hw, msg, wpm, lpm)

    of WM_CONTEXTMENU:
        if this.mContextMenu != nil: this.mContextMenu.showMenu(lpm)

    of WM_NOTIFY: # This is from header.
        let nmh = cast[LPNMHDR](lpm)
        if nmh.code == NM_CUSTOMDRAW_NM:  # Let's draw header back & fore colors
            var nmcd = cast[LPNMCUSTOMDRAW](lpm)
            case nmcd.dwDrawStage # NM_CUSTOMDRAW is always -12 when item painting
            of CDDS_PREPAINT: return CDRF_NOTIFYITEMDRAW
            of CDDS_ITEMPREPAINT:
                # We are drawing our headers.
                return this.headerCustomDraw(nmcd)
            else: discard

    of MM_NOTIFY_REFLECT:
        let nmh = cast[LPNMHDR](lpm)
        case nmh.code
        of NM_CUSTOMDRAW_NM:
            var nmLvcd = cast[LPNMLVCUSTOMDRAW](lpm)
            case nmLvcd.nmcd.dwDrawStage
            of CDDS_PREPAINT: return CDRF_NOTIFYITEMDRAW
            of CDDS_ITEMPREPAINT:
                nmLvcd.clrTextBk = this.mBackColor.cref
                return CDRF_NEWFONT or CDRF_DODEFAULT
            else: discard

        of LVN_ITEMCHANGED:
            var nmlv = cast[LPNMLISTVIEW](lpm)
            if nmlv.uNewState == 8192 or nmlv.uNewState == 4096:
                this.mChecked = (if nmlv.uNewState == 8192: true else: false)
                if this.onCheckedChanged != nil: this.onCheckedChanged(this, newEventArgs())
            else:
                if nmlv.uNewState == 3:
                    this.mSelIndex = nmlv.iItem
                    this.mSelSubIndex = nmlv.iSubItem
                    if this.onSelectionChanged != nil: this.onSelectionChanged(this, newEventArgs())

        of NM_DBLCLK:
            if this.onItemDoubleClicked != nil: this.onItemDoubleClicked(this, newEventArgs())

        of NM_CLICK:
            let nmia = cast[LPNMITEMACTIVATE](lpm)
            if this.onItemClicked != nil: this.onItemClicked(this, newEventArgs())

        of NM_HOVER:
            if this.onItemHover != nil: this.onItemHover(this, newEventArgs())
        else: discard

    else: return DefSubclassProc(hw, msg, wpm, lpm)
    return DefSubclassProc(hw, msg, wpm, lpm)


proc hdrWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.} =
    var this = cast[ListView](refData)
    case msg
    of WM_DESTROY:
        RemoveWindowSubclass(hw, hdrWndProc, scID)

    of WM_MOUSEMOVE:
        var hinfo: HDHITTESTINFO
        hinfo.pt = getMousePos(lpm)
        this.mHotHdrIndex = cast[DWORD_PTR](SendMessageW(hw, HDM_HITTEST, 0, cast[LPARAM](hinfo.unsafeAddr)))

    of WM_MOUSELEAVE: this.mHotHdrIndex = cast[DWORD_PTR](-1)

    of HDM_LAYOUT:
        if this.mChangeHdrHeight:
            var pHl = cast[LPHDLAYOUT](lpm)
            pHl.pwpos.hwnd = hw
            pHl.pwpos.flags = SWP_FRAMECHANGED
            pHl.pwpos.x = pHl.prc.left
            pHl.pwpos.y = 0
            pHl.pwpos.cx = (pHl.prc.right - pHl.prc.left)
            pHl.pwpos.cy = this.mHdrHeight
            pHl.prc.top = this.mHdrHeight
            return 1

    of WM_PAINT:
        discard DefSubclassProc(hw, msg, wpm, lpm)
        var hrc: RECT
        SendMessageW(hw, HDM_GETITEMRECT, cast[WPARAM](int32(this.mColumns.len - 1)), cast[LPARAM](hrc.unsafeAddr))
        var rc = RECT(left: hrc.right + 1, top: hrc.top, right: this.width, bottom: hrc.bottom)
        var hdc: HDC = GetDC(hw)
        FillRect(hdc, rc.unsafeAddr, this.mHdrBkBrush)
        ReleaseDC(hw, hdc)
        return 0

    else: return DefSubclassProc(hw, msg, wpm, lpm)
    return DefSubclassProc(hw, msg, wpm, lpm)