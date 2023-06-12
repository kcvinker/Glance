# treeview module Created on 05-Apr-2023 12:51 AM; Author kcvinker[Added to Glance on 04-Jun-2023 02:14]
# TreeView type
#   Constructor - newTreeView*(parent: Form, x, y: int32 = 10, w: int32 = 200, h: int32 = 150): TreeView
#   Functions
        # createHandle() - Create the handle of treeView
        # addNode*(nodeText: string) : TreeNode {.discardable.}
        # addNode*(node: TreeNode)
        # addChildNode*(nodeText: string, parent: TreeNode) : TreeNode {.discardable.}
        # addChildNode*(node: TreeNode, parent: TreeNode)
        # insertNode*(nodeText: string, position: int32) : TreeNode {.discardable.}
        # insertNode*(node: TreeNode, position: int32)
        # insertChildNode*(nodeText: string, parent: TreeNode, position: int32) : TreeNode {.discardable.}
        # insertChildNode*(node: TreeNode, parent: TreeNode, position: int32)
        # deleteSelNode*(index: int32): bool
        # expandAll*()

#     Properties - Getter & Setter available
#       Name            Type
        # font              Font
        # text              string
        # width             int32
        # height            int32
        # xpos              int32
        # ypos              int32
        # backColor         Color
        # foreColor         Color

        # noLine            bool
        # noButton          bool
        # hasCheckBox       bool
        # fullRowSelect     bool
        # isEditable        bool
        # showSelection     bool
        # hotTrack          bool
        # nodeCount         int32
        # uniqNodeID        int32
        # lineColor         Color, For setter, uint is also acceptable
        # selectedNode      TreeNode
        # nodes             seq[TreeNode]

    # Events
    #     onMouseEnter*, onClick*, onMouseLeave*, onRightClick*, onDoubleClick*,
    #     onLostFocus*, onGotFocus*: EventHandler - proc(c: Control, e: EventArgs)

    #     onMouseWheel*, onMouseHover*, onMouseMove*, onMouseDown*, onMouseUp*
    #     onRightMouseDown*, onRightMouseUp*: MouseEventHandler - - proc(c: Control, e: MouseEventArgs)

        # onBeginEdit, onEndEdit, onNodeDeleted : EventHandler
        # onBeforeChecked, onAfterChecked, onBeforeSelected: TreeEventHandler
        # onAfterSelected, onBeforeExpanded, onAfterExpanded: TreeEventHandler
        # onBeforeCollapsed, onAfterCollapsed: TreeEventHandler - proc(c: Control, e: TreeEventArgs)
#-----------------------------------------------------------------------------------------------------

# TreeNode type
    # Constructor - newTreeNode*(text: string, img, selImg: int32 = -1): TreeNode
    # Functions
        # addChildNode*(nodeText: string) : TreeNode {.discardable.}
        # addChildNode*(chNode: TreeNode)
        # insertChildNode*(nodeText: string, position: int32) : TreeNode {.discardable.}
        # insertChildNode*(node: TreeNode, position: int32)

#     Properties - Getter & Setter available
#       Name                          Type
        # nodes                     seq[TreeNode] (Getter only)
        # index                     int32 (Getter only)
        # text                      string
        # imageIndex                int32
        # selectedImageIndex        int32
        # childCount                int32
        # nodeID                    int32
        # checked                   bool
        # foreColor                 Color, For setter, uint is also acceptable

# Constants
const
    TVS_HASBUTTONS = 0x0001
    TVS_HASLINES = 0x0002
    TVS_LINESATROOT = 0x0004
    TVS_EDITLABELS = 0x0008
    TVS_DISABLEDRAGDROP = 0x0010
    TVS_SHOWSELALWAYS = 0x0020
    TVS_RTLREADING = 0x0040
    TVS_NOTOOLTIPS = 0x0080
    TVS_CHECKBOXES = 0x0100
    TVS_TRACKSELECT = 0x0200
    TVS_SINGLEEXPAND = 0x0400
    TVS_INFOTIP = 0x0800
    TVS_FULLROWSELECT = 0x1000
    TVS_NOSCROLL = 0x2000
    TVS_NONEVENHEIGHT = 0x4000
    TVS_NOHSCROLL = 0x8000 # TVS_NOSCROLL overrides this
    TVS_EX_NOSINGLECOLLAPSE = 0x0001
    TVS_EX_MULTISELECT = 0x0002
    TVS_EX_DOUBLEBUFFER = 0x0004
    TVS_EX_NOINDENTSTATE = 0x0008
    TVS_EX_RICHTOOLTIP = 0x0010
    TVS_EX_AUTOHSCROLL = 0x0020
    TVS_EX_FADEINOUTEXPANDOS = 0x0040
    TVS_EX_PARTIALCHECKBOXES = 0x0080
    TVS_EX_EXCLUSIONCHECKBOXES = 0x0100
    TVS_EX_DIMMEDCHECKBOXES = 0x0200
    TVS_EX_DRAWIMAGEASYNC = 0x0400
    TVIF_TEXT = 0x0001
    TVIF_IMAGE = 0x0002
    TVIF_PARAM = 0x0004
    TVIF_STATE = 0x0008
    TVIF_SELECTEDIMAGE = 0x0020
    TVIF_STATEEX = 0x100

    TVIS_SELECTED = 0x0002
    TVIS_CUT = 0x0004
    TVIS_DROPHILITED = 0x0008
    TVIS_BOLD = 0x0010
    TVIS_EXPANDED = 0x0020
    TVIS_EXPANDEDONCE = 0x0040
    TVIS_EXPANDPARTIAL = 0x0080
    TVIS_OVERLAYMASK = 0x0F00
    TVIS_STATEIMAGEMASK = 0xF000
    TVIS_USERMASK = 0xF000
    TVIS_EX_FLAT = 0x0001
    TVIS_EX_DISABLED = 0x0002
    TVIS_EX_ALL = 0x0002
    TVIS_EX_TEXTCOLOR = 0x00000004

    TVGN_ROOT = 0x0
    TVGN_CARET = 0x9

    TVE_EXPAND = 0x2
    TVE_EXPANDPARTIAL = 0x4000

    TVI_ROOT = cast[HTREEITEM](-0x10000) #(ULONG_MAX-0x10000)
    TVI_FIRST = cast[HTREEITEM](-0x0FFFF)  #(ULONG_MAX-0x0FFFF)
    TVI_LAST = cast[HTREEITEM](-0x0FFFE)
    TVI_SORT = cast[HTREEITEM](-0x0FFFD)

    TV_FIRST = 0x1100
    TVM_DELETEITEM = (TV_FIRST + 1)

    TVM_EXPAND = TV_FIRST+2
    TVM_SETIMAGELIST = (TV_FIRST + 9)
    TVM_GETNEXTITEM = (TV_FIRST + 10)
    TVM_SETBKCOLOR = (TV_FIRST + 29)
    TVM_SETTEXTCOLOR = (TV_FIRST + 30)
    TVM_SETLINECOLOR = (TV_FIRST + 40)
    TVM_INSERTITEMW = (TV_FIRST + 50)
    TVM_GETITEMW = TV_FIRST + 62

    NM_TVSTATEIMAGECHANGING_NM = (NM_FIRST - 24)
    TVN_ITEMCHANGINGW = TVN_FIRST-17
    TVN_ITEMCHANGEDW = TVN_FIRST-19


var tvCount = 1
let TVSTYLE : DWORD = WS_BORDER or WS_CHILD or WS_VISIBLE or TVS_HASLINES or TVS_HASBUTTONS or TVS_LINESATROOT or TVS_DISABLEDRAGDROP
# Forward declaration
proc tvWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.}


# TreeView constructor 200, 150
proc newTreeView*(parent: Form, x, y, w, h: int32): TreeView {.
                            exportc:"newTreeView", stdcall, dynlib.} =
    new(result)
    result.mKind = ctTreeView
    result.mClassName = "SysTreeView32"
    result.mName = "TreeView_" & $tvCount
    result.mParent = parent
    result.mXpos = x
    result.mYpos = y
    result.mWidth = w
    result.mHeight = h
    result.mFont = parent.mFont
    result.mStyle = TVSTYLE
    result.mExStyle = 0
    result.mBackColor = CLR_WHITE
    result.mForeColor = CLR_BLACK
    result.mLineColor = CLR_BLACK
    result.mUniqNodeID = 100
    result.mParent.controls.add(result)
    result.mCtlID = globalCtlID
    globalCtlID += 1
    tvCount += 1




proc newTreeNode*(text: ref Wstring, img, selImg: int32 = -1): TreeNode =
    new(result)
    result.mImgIndex = img
    result.mSelImgIndex = selImg
    result.mForeColor = CLR_BLACK
    result.mBackColor = CLR_WHITE
    result.mText = text[]
    result.mIndex = -1

proc setTVStyle(this: TreeView) =
    if this.mNoLine: this.mStyle = this.mStyle xor TVS_HASLINES
    if this.mNoButton: this.mStyle = this.mStyle xor TVS_HASBUTTONS
    if this.mHasCheckBox: this.mStyle = this.mStyle or TVS_CHECKBOXES
    if this.mFullRowSel: this.mStyle = this.mStyle or TVS_FULLROWSELECT
    if this.mEditable: this.mStyle = this.mStyle or TVS_EDITLABELS
    if this.mShowSel: this.mStyle = this.mStyle or TVS_SHOWSELALWAYS
    if this.mHotTrack: this.mStyle = this.mStyle or TVS_TRACKSELECT
    if this.mNoButton and this.mNoLine: this.mStyle = this.mStyle xor TVS_LINESATROOT
    this.mBkBrush = CreateSolidBrush(this.mBackColor.cref)

proc sendInitialMessages(this: TreeView) =
    if this.mBackColor.value != 0xFFFFFF: this.sendMsg(TVM_SETBKCOLOR, 0, this.mBackColor.cref)
    if this.mForeColor.value != 0x000000: this.sendMsg(TVM_SETTEXTCOLOR, 0, this.mForeColor.cref)
    if this.mLineColor.value != 0x000000: this.sendMsg(TVM_SETLINECOLOR, 0, this.mLineColor.cref)

proc addNodeInternal(this: TreeView, node: TreeNode, nop: NodeOps,
                            pnode: TreeNode = nil, pos: int32 = -1) =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    node.mIsCreated = true
    node.mTreeHandle = this.mHandle
    node.mNodeID = this.mUniqNodeID # We can identify any node

    var tvi: TVITEMEXW
    tvi.mask = TVIF_TEXT or TVIF_PARAM
    tvi.pszText = node.mText[0].unsafeAddr
    tvi.cchTextMax = int32(node.mText.len)
    tvi.iImage = node.mImgIndex
    tvi.iSelectedImage = node.mSelImgIndex
    tvi.stateMask = TVIS_USERMASK
    if node.mImgIndex > -1: tvi.mask = tvi.mask or TVIF_IMAGE
    if node.mSelImgIndex > -1: tvi.mask = tvi.mask or TVIF_SELECTEDIMAGE

    var tis: TVINSERTSTRUCTW
    tis.itemex = tvi
    tis.itemex.lParam = cast[LPARAM](cast[PVOID](node))

    var isRootNode = false
    var errMsg = "Can't Add"

    case nop
    of noAddNode:
        node.mIndex = this.mNodeCount
        tis.hParent = TVI_ROOT
        tis.hInsertAfter = (if this.mNodeCount > 0: this.mNodes[this.mNodeCount - 1].mHandle else: TVI_FIRST)
        isRootNode = true
    of noInsertNode:
        node.mIndex = this.mNodeCount
        tis.hParent = TVI_ROOT
        tis.hInsertAfter = (if pos == 0: TVI_FIRST else: this.mNodes[pos - 1].mHandle)
        isRootNode = true
        errMsg = "Can't Insert"
    of noAddChild:
        node.mIndex = pnode.mNodeCount
        tis.hInsertAfter = TVI_LAST
        tis.hParent = pnode.mHandle
        node.mParentNode = pnode
        errMsg = "Can't Add Child"
    of noInsertChild:
        node.mIndex = pnode.mNodeCount
        tis.hParent = pnode.mHandle
        tis.hInsertAfter = (if pos == 0: TVI_FIRST else: pnode.mNodes[pos - 1].mHandle)
        node.mParentNode = pnode
        errMsg = "Can't Insert Child"

    let hItem =  cast[HTREEITEM](this.sendMsg(TVM_INSERTITEMW, 0, tis.unsafeAddr))
    # echo "tvm-ins result ", hItem.repr
    if hItem != nil:
        node.mHandle = hItem
        this.mUniqNodeID += 1
        if isRootNode:
            this.mNodes.add(node)
            this.mNodeCount += 1
        else:
            pnode.mNodes.add(node)
            pnode.mNodeCount += 1
    else:
        let errNo = GetLastError()
        echo(errMsg & " node!, Error - " & $errNo )

proc setNodeText(this: TreeView, node: TreeNode) = # Implement this
    echo node.mText.repr

proc sendMsg(this: TreeNode, uMsg: UINT, wpm, lpm: auto) : LRESULT {.discardable.} =
    result = SendMessageW(this.mTreeHandle, uMsg, cast[WPARAM](wpm), cast[LPARAM](lpm))

# We need this function to recurseively traverse all the nodes and expand them.
proc expandNode(this: TreeNode) =
    this.sendMsg(TVM_EXPAND, TVE_EXPAND, this.mHandle)
    if this.mNodeCount > 0:
        for node in this.mNodes: node.expandNode()

proc createNewNodeInfo(node: TreeNode, nodeOp: NodeOps,
                        pnode: TreeNode = nil, pos: int32 = -1 ) : NewNodeInfo =
    new(result)
    result.node = node
    result.parent = pnode
    result.opMode = nodeOp
    result.position = pos


# Create TreeView's hwnd
method createHandle*(this: TreeView) =
    this.setTVStyle()
    this.createHandleInternal()
    if this.mHandle != nil:
        this.setSubclass(tvWndProc)
        this.setFontInternal()
        this.sendInitialMessages()



proc addNode(this: TreeView, nodeText: LPCWSTR) {.exportc:"tvAddNode1", stdcall, dynlib, discardable.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    var node = newTreeNode(toWstring2(nodeText))
    this.addNodeInternal(node, noAddNode)

proc addNode*(this: TreeView, node: TreeNode) {.exportc:"tvAddNode2", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    this.addNodeInternal(node, noAddNode)

proc addNodes*(this: TreeView, nodeText: LPCWSTR) {.exportc:"tvAddNodes", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    var wtext = toWstring2(nodeText)
    var namesSeq = splitWstring2(wtext, pipeChar)
    for name in namesSeq:
        var node = newTreeNode(name)
        this.addNodeInternal(node, noAddNode)






proc addChildNode*(this: TreeView, parent: TreeNode, nodeText: LPCWSTR) {.exportc:"tvAddChildNode1", stdcall, dynlib, } =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    var node = newTreeNode(toWstring2(nodeText))
    this.addNodeInternal(node, noAddChild, parent)

proc addChildNode*(this: TreeView, node: TreeNode, parent: TreeNode) {.exportc:"tvAddChildNode2", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    this.addNodeInternal(node, noAddChild, parent)

proc addChildNode*(this: TreeView, pnIndex: int, nodeText: LPCWSTR) {.exportc:"tvAddChildNode3", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    var node = newTreeNode(toWstring2(nodeText))
    if pnIndex < this.mNodes.len:
        this.addNodeInternal(node, noAddChild, this.mNodes[pnIndex])



proc addChildNodes*(this: TreeView, pnIndex: int, nodeText: LPCWSTR) {.exportc:"tvAddChildNodes1", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    if pnIndex < this.mNodes.len:
        var wtext = toWstring2(nodeText)
        var namesSeq = splitWstring2(wtext, pipeChar)
        for name in namesSeq:
            var node = newTreeNode(name)
            this.addNodeInternal(node, noAddChild, this.mNodes[pnIndex])

proc addChildNodes*(this: TreeView, pnode: TreeNode, nodeText: LPCWSTR) {.exportc:"tvAddChildNodes2", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    var wtext = toWstring2(nodeText)
    var namesSeq = splitWstring2(wtext, pipeChar)
    for name in namesSeq:
        var node = newTreeNode(name)
        this.addNodeInternal(node, noAddChild, pnode)



proc insertNode*(this: TreeView, nodeText: LPCWSTR, position: int32) {.exportc:"tvInsertNode1", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    var node = newTreeNode(toWstring2(nodeText))
    this.addNodeInternal(node, noInsertNode, pos = position)

proc insertNode*(this: TreeView, node: TreeNode, position: int32) {.exportc:"tvInsertNode2", stdcall, dynlib.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    this.addNodeInternal(node, noInsertNode, pos = position)



proc insertChildNode*(this: TreeView, nodeText: LPCWSTR, parent: TreeNode, position: int32) {.
                            exportc:"tvInsertChildNode1", stdcall, dynlib, discardable.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    var node = newTreeNode(toWstring2(nodeText))
    this.addNodeInternal(node, noInsertChild, parent, position)

proc insertChildNode*(this: TreeView, node: TreeNode, parent: TreeNode, position: int32) {.
                                exportc:"tvInsertChildNode2", stdcall, dynlib, discardable.} =
    if not this.mIsCreated: raise newException(Exception, "Treeview handle is invalid")
    this.addNodeInternal(node, noInsertChild, parent, position)



proc deleteSelNode*(this: TreeView, index: int32): bool {.
                            exportc:"tvDeleteSelNode", stdcall, dynlib, discardable.} =
    let selItem = cast[HTREEITEM](this.sendMsg(TVM_GETNEXTITEM, TVGN_CARET, 0))
    if selItem != nil:
        result = bool(this.sendMsg(TVM_DELETEITEM, 0, selItem))

# Expand all nodes in this tree view
proc expandAll*(this: TreeView) {.exportc:"tvExpandAll", stdcall, dynlib, discardable.} =
    if this.mIsCreated:
        for node in this.mNodes: node.expandNode()




# TreeNode functions------------------------------------------------------------
proc newNodeNotify(nod: TreeNode, pnode: TreeNode, nop: NodeOps, p: int32 = -1) : NodeNotify =
    new(result)
    result.node = nod
    result.parent = pnode
    result.nops = nop
    result.pos = p

proc nnDataToLparm(nnData: NodeNotify): LPARAM = cast[LPARAM](cast[PVOID](nnData))
proc nodeToWparm(node: TreeNode): WPARAM = cast[WPARAM](cast[PVOID](node))
proc nodeToLparm(node: TreeNode): LPARAM = cast[LPARAM](cast[PVOID](node))

proc addChildNode*(this: TreeNode, nodeText: LPCWSTR) : TreeNode {.
                        exportc:"treeNodeAddChildNode1", stdcall, dynlib, discardable, discardable.} =
    result = newTreeNode(toWstring2(nodeText))
    let nnData = newNodeNotify(result, this, noAddChild)
    this.sendMsg(MM_NODE_NOTIFY, naAddNode, cast[PVOID](nnData))


proc addChildNode*(this: TreeNode, chNode: TreeNode) {.
                        exportc:"treeNodeAddChildNode2", stdcall, dynlib, discardable.} =
    let nnData = newNodeNotify(chNode, this, noAddChild)
    this.sendMsg(MM_NODE_NOTIFY, naAddNode, cast[PVOID](nnData))

proc insertChildNode*(this: TreeNode, nodeText: LPCWSTR, position: int32) : TreeNode {.discardable.} =
    result = newTreeNode(toWstring2(nodeText))
    let nnData = newNodeNotify(result, this, noInsertChild, position)
    this.sendMsg(MM_NODE_NOTIFY, naAddNode, cast[PVOID](nnData))

proc insertChildNode*(this: TreeNode, node: TreeNode, position: int32) =
    let nnData = newNodeNotify(node, this, noInsertChild, position)
    this.sendMsg(MM_NODE_NOTIFY, naAddNode, cast[PVOID](nnData))





#TreeView Properties------------------------------------------------------------------------
proc nodes*(this: TreeView) : seq[TreeNode] = this.mNodes
proc selectedNode*(this: TreeView): TreeNode = this.mSelNode

proc foreColor*(this: TreeView): Color = this.mForeColor
proc `foreColor=`*(this: TreeView, value: uint) =
    this.mForeColor = newColor(value)
    this.sendMsg(TVM_SETTEXTCOLOR, 0, this.mForeColor.cref)
    this.checkRedraw()

proc noLine*(this: TreeView): bool = this.mNoLine
proc `noLine=`*(this: TreeView, value: bool) = this.mNoLine = value

proc noButton*(this: TreeView): bool = this.mNoButton
proc `noButton=`*(this: TreeView, value: bool) = this.mNoButton = value

proc hasCheckBox*(this: TreeView): bool = this.mHasCheckBox
proc `hasCheckBox=`*(this: TreeView, value: bool) = this.mHasCheckBox = value

proc fullRowSelect*(this: TreeView): bool = this.mFullRowSel
proc `fullRowSelect=`*(this: TreeView, value: bool) = this.mFullRowSel = value

proc isEditable*(this: TreeView): bool = this.mEditable
proc `isEditable=`*(this: TreeView, value: bool) = this.mEditable = value

proc showSelection*(this: TreeView): bool = this.mShowSel
proc `showSelection=`*(this: TreeView, value: bool)= this.mShowSel = value

proc hotTrack*(this: TreeView): bool = this.mHotTrack
proc `hotTrack=`*(this: TreeView, value: bool) = this.mHotTrack = value

proc nodeCount*(this: TreeView): int32 = this.mNodeCount
proc `nodeCount=`*(this: TreeView, value: int32) = this.mNodeCount = value

proc uniqNodeID*(this: TreeView): int32 = this.mUniqNodeID
proc `uniqNodeID=`*(this: TreeView, value: int32) = this.mUniqNodeID = value

proc lineColor*(this: TreeView): Color = this.mLineColor
proc `lineColor=`*(this: TreeView, value: uint) = this.mLineColor =  newColor(value)




# TreeNode properties-------------------------------------------------------
proc nodes*(this: TreeNode) : seq[TreeNode] = this.mNodes
proc index*(this: TreeNode): int32 = this.mIndex
proc text*(this: TreeNode): Wstring = this.mText
proc `text=`*(this: TreeNode, value: Wstring) =
    this.mText = value
    if this.mIsCreated:
        this.sendMsg(MM_NODE_NOTIFY, naSetText, cast[PVOID](this))

proc imageIndex*(this: TreeNode): int32 = this.mImgIndex
proc selectedImageIndex*(this: TreeNode): int32 = this.mSelImgIndex
proc childCount*(this: TreeNode): int32 = this.mChildCount
# proc childCount*(this: TreeNode): int32 = this.mChildCount
proc nodeID*(this: TreeNode): int32 = this.mNodeID
proc checked*(this: TreeNode): bool = this.mChecked
proc foreColor*(this: TreeNode): Color = this.mForeColor
proc `foreColor=`*(this: TreeNode, value: uint) =
    this.mForeColor = newColor(value)
    if this.mIsCreated: InvalidateRect(this.mTreeHandle, nil, 0)


# proc baackColor*(this: TreeNode): Color = this.mBackColor
# proc `baackColor=`*(this: TreeNode, value: uint) =
#     this.mBackColor = newColor(value)
#     if this.mIsCreated: InvalidateRect(this.mTreeHandle, nil, 0)

proc parentNode*(this: TreeNode): TreeNode = this.mParentNode


proc setTreeViewEvents(this: TreeView, evtIndex: TreeViewEvents, funcPtr: EventHandler) =
    case evtIndex
    of tvBeginEdit: this.onBeginEdit = funcPtr
    of tvEndEdit: this.onEndEdit = funcPtr
    of tvNodeDeleted: this.onNodeDeleted = funcPtr
    of tvItemDblClicked: this.onNodeDoubleClicked = funcPtr
    of tvBeforeChecked: this.onBeforeChecked = cast[TreeEventHandler](funcPtr)
    of tvAfterChecked: this.onAfterChecked = cast[TreeEventHandler](funcPtr)
    of tvBeforeSelected: this.onBeforeSelected = cast[TreeEventHandler](funcPtr)
    of tvAfterSelected: this.onAfterSelected = cast[TreeEventHandler](funcPtr)
    of tvBeforeExpanded: this.onBeforeExpanded = cast[TreeEventHandler](funcPtr)
    of tvAfterExpanded: this.onAfterExpanded = cast[TreeEventHandler](funcPtr)
    of tvBeforeCollapsed: this.onBeforeCollapsed = cast[TreeEventHandler](funcPtr)
    of tvAfterCollapsed: this.onAfterCollapsed = cast[TreeEventHandler](funcPtr)

proc setTreeViewProps(this: TreeView, prop: TreeViewProps, value: pointer) =
    case prop
    of tvNoLine: this.noLine = cast[bool](cast[ref int](value)[])
    of tvNoButton: this.noButton = cast[bool](cast[ref int](value)[])
    of tvHasCheckBox: this.hasCheckBox = cast[bool](cast[ref int](value)[])
    of tvFullRowSelect: this.fullRowSelect = cast[bool](cast[ref int](value)[])
    of tvIsEditable: this.isEditable = cast[bool](cast[ref int](value)[])
    of tvShowSelection: this.showSelection = cast[bool](cast[ref int](value)[])
    of tvHotTrack: this.hotTrack = cast[bool](cast[ref int](value)[])
    of tvNodeCount: discard
    of tvUniqNodeID: discard
    of tvLineColor: this.lineColor = cast[ref uint](value)[]
    of tvSelectedNode: discard# this.selectedNode = cast[TreeNode](value)

proc getTreeViewProps(this: TreeView, prop: TreeViewProps, value: pointer) =
    case prop
    of tvNoLine: cast[ref bool](value)[] = this.noLine
    of tvNoButton: cast[ref bool](value)[] = this.noButton
    of tvHasCheckBox: cast[ref bool](value)[] = this.hasCheckBox
    of tvFullRowSelect: cast[ref bool](value)[] = this.fullRowSelect
    of tvIsEditable: cast[ref bool](value)[] = this.isEditable
    of tvShowSelection: cast[ref bool](value)[] = this.showSelection
    of tvHotTrack: cast[ref bool](value)[] = this.hotTrack
    of tvNodeCount: cast[ref int32](value)[] = this.nodeCount
    of tvUniqNodeID: cast[ref int32](value)[] = this.uniqNodeID
    of tvLineColor: cast[ref uint](value)[] = this.lineColor.value
    of tvSelectedNode: cast[ref TreeNode](value)[] = this.selectedNode




proc tvWndProc(hw: HWND, msg: UINT, wpm: WPARAM, lpm: LPARAM, scID: UINT_PTR, refData: DWORD_PTR): LRESULT {.stdcall.} =
    var this = cast[TreeView](refData)
    case msg
    of WM_DESTROY:
        this.destructor()
        RemoveWindowSubclass(hw, tvWndProc, scID)

    of WM_LBUTTONDOWN: this.leftButtonDownHandler(msg, wpm, lpm)
    of WM_LBUTTONUP: this.leftButtonUpHandler(msg, wpm, lpm)
    of WM_RBUTTONDOWN: this.rightButtonDownHandler(msg, wpm, lpm)
    of WM_RBUTTONUP: this.rightButtonUpHandler(msg, wpm, lpm)
    of WM_MOUSEMOVE: this.mouseMoveHandler(msg, wpm, lpm)
    of WM_MOUSELEAVE: this.mouseLeaveHandler()
    of WM_CONTEXTMENU:
        if this.mContextMenu != nil: this.mContextMenu.showMenu(lpm)

    of WM_PAINT: return this.paintHandler(hw, msg, wpm, lpm)

    of MM_NODE_NOTIFY: # Received when a node wants to add a child node
        var action = cast[NodeAction](wpm)
        case action
        of naAddNode:
            var nnd = cast[NodeNotify](cast[PVOID](lpm))
            this.addNodeInternal(nnd.node, nnd.nops, nnd.parent)
        of naSetText: this.setNodeText(cast[TreeNode]([cast[PVOID](lpm)]))
        else: discard

    of MM_NOTIFY_REFLECT:
        let nmh = cast[LPNMHDR](lpm)
        case nmh.code
        of NM_CLICK: discard
        of NM_DBLCLK:discard
        of NM_CUSTOMDRAW_NM:
            var nmtv = cast[LPNMTVCUSTOMDRAW](lpm)
            case nmtv.nmcd.dwDrawStage:
            of CDDS_PREPAINT: return CDRF_NOTIFYITEMDRAW
            of CDDS_ITEMPREPAINT:
                var node = cast[TreeNode](cast[PVOID](nmtv.nmcd.lItemlParam))
                # nmtv.clrText = node.mForeColor.cref
                # nmtv.clrTextBk = node.mBackColor.cref
                return CDRF_DODEFAULT
            else: discard

        of TVN_DELETEITEMW:
            if this.onNodeDeleted != nil: this.onNodeDeleted(this, newEventArgs())

        of TVN_SELCHANGINGW:
            if this.onBeforeSelected != nil:
                var nmtv = cast[LPNMTREEVIEWW](lpm)
                this.onBeforeSelected(this, newTreeEventArgs(nmtv))

        of TVN_SELCHANGEDW:
            let nmtv = cast[LPNMTREEVIEWW](lpm)
            var tea = newTreeEventArgs(nmtv)
            this.mSelNode = tea.mNode
            if this.onAfterSelected != nil: this.onAfterSelected(this, tea)

        of TVN_ITEMEXPANDINGW :
            let nmtv = cast[LPNMTREEVIEWW](lpm)
            if nmtv.action == 1:
                if this.onBeforeCollapsed != nil:
                    var tea = newTreeEventArgs(nmtv)
                    this.onBeforeCollapsed(this, tea)
            elif nmtv.action == 2:
                if this.onBeforeExpanded != nil:
                    var tea = newTreeEventArgs(nmtv)
                    this.onBeforeExpanded(this, tea)

        of TVN_ITEMEXPANDEDW:
            let nmtv = cast[LPNMTREEVIEWW](lpm)
            if nmtv.action == 1:
                if this.onAfterCollapsed != nil:
                    var tea = newTreeEventArgs(nmtv)
                    this.onAfterCollapsed(this, tea)
            elif nmtv.action == 2:
                if this.onAfterExpanded != nil:
                    var tea = newTreeEventArgs(nmtv)
                    this.onAfterExpanded(this, tea)

        of NM_TVSTATEIMAGECHANGING_NM:
            let tvsic = cast[LPNMTVSTATEIMAGECHANGING](lpm)
            if tvsic.iOldStateImageIndex == 1:
                this.mNodeChecked = true
            elif tvsic.iOldStateImageIndex == 2:
                this.mNodeChecked = false

        of TVN_ITEMCHANGINGW:
            if this.onBeforeChecked != nil:
                let tvic = cast[LPNMTVITEMCHANGE](lpm)
                var tea = newTreeEventArgs(tvic)
                tea.mNode.mChecked = this.mNodeChecked
                this.onBeforeChecked(this, tea)

        of TVN_ITEMCHANGEDW:
            if this.onAfterChecked != nil:
                let tvic = cast[LPNMTVITEMCHANGE](lpm)
                var tea = newTreeEventArgs(tvic)
                tea.mNode.mChecked = this.mNodeChecked
                this.onAfterChecked(this, tea)

        else: discard
        return 0

    else: return DefSubclassProc(hw, msg, wpm, lpm)
    return DefSubclassProc(hw, msg, wpm, lpm)
