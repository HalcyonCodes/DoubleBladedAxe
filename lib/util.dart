import './components/util/status_util.dart';
import 'package:flutter/material.dart';

class ListUtil {
  //播放加载下一个状态指示器的动画
  Future<void> Function(Function())? _startLoadMoreStatusCardAnimate;
  Future<void> Function(Function())? get startLoadMoreStatusCardAniamte =>
      _startLoadMoreStatusCardAnimate;
  void setStartLoadMoreStatusCardAnimate(
      Future<void> Function(Function())? func) {
    _startLoadMoreStatusCardAnimate = func;
  }

  //倒放加载下一个状态指示器动画
  Future<void> Function(Function())? _reverseLoadMoreStatusCardAnimate;
  Future<void> Function(Function())? get reversetLoadMoreStatusCardAniamte =>
      _reverseLoadMoreStatusCardAnimate;
  void setReverseLoadMoreStatusCardAnimate(
      Future<void> Function(Function())? func) {
    _reverseLoadMoreStatusCardAnimate = func;
  }

  //播放加载上一个状态指示器的动画
  Future<void> Function(Function())? _startLoadPreStatusCardAnimate;
  Future<void> Function(Function())? get startLoadPreStatusCardAniamte =>
      _startLoadPreStatusCardAnimate;
  void setStartLoadPreStatusCardAnimate(
      Future<void> Function(Function())? func) {
    _startLoadPreStatusCardAnimate = func;
  }

  //倒放加载上一个状态指示器的动画
  Future<void> Function(Function())? _reverseLoadPreStatusCardAnimate;
  Future<void> Function(Function())? get reversetLoadPreStatusCardAniamte =>
      _reverseLoadPreStatusCardAnimate;
  void setReseverLoadPreStatusCardAnimate(
      Future<void> Function(Function())? func) {
    _reverseLoadPreStatusCardAnimate = func;
  }

  //指示是否是listView
  bool _isListView = false;
  bool get isListView => _isListView;
  void setIsListView(bool b) {
    _isListView = b;
  }

  //获得新加载的SingleChildScrollView里用于过度的页面的高度
  Future<double> Function()? _getSinglePageHeight;
  Future<double> Function()? get getSinglePageHeight => _getSinglePageHeight;
  void setFuncGetSinglePageHeight(Future<double> Function()? func) {
    _getSinglePageHeight = func;
  }

  //设置滚动条状态
  Status _status = Status.statusIdel;
  Status get status => _status;
  void setStatus(Status s) {
    _status = s;
    setStatuText();
  }

  //设置滚动条状态字符串
  String _statusText = '加载完成';
  String get statusText => _statusText;
  void setStatuText() {
    switch (status) {
      case Status.statusHeadLoading:
        _statusText = '加载中';
        break;
      case Status.statusFootLoading:
        _statusText = '加载中';
        break;
      case Status.statusIdel:
        _statusText = '加载完成';
        break;
      case Status.statusFootLoadFaild:
        _statusText = '加载失败';
        break;
      case Status.statusFootLoadCompleted:
        _statusText = '加载完成';
        break;
      case Status.statusMath:
        _statusText = '加载完成';
        break;
      case Status.statusHeadLoadCompleted:
        _statusText = '加载完成';
        break;
      case Status.statusHeadLoadFaild:
        _statusText = '加载失败';
        break;
    }
  }

  //用于调用http请求并组装组件列表的函数
  Future<List<Widget>> Function()? _getLoadPreWidgets;
  Future<List<Widget>> Function()? get getLoadPreWidgets => _getLoadPreWidgets;
  void setFuncGetLoadPreWidgets(
      Future<List<Widget>> Function()? getHttpWidgets) {
    _getLoadPreWidgets = getHttpWidgets;
  }

  //用于调用http请求并组装组件列表的函数
  Future<List<Widget>> Function()? _getLoadMoreWidgets;
  Future<List<Widget>> Function()? get getLoadMoreWidgets =>
      _getLoadMoreWidgets;
  void setFuncGetLoadMoreWidgets(
      Future<List<Widget>> Function()? getHttpWidgets) {
    _getLoadMoreWidgets = getHttpWidgets;
  }

  //窗口的高度
  double? _screenHeight;
  double? get screenHeight => _screenHeight;
  void setScreenHeight(double height) {
    _screenHeight = height;
  }

  //滚动条
  ScrollController? _scrollController;
  ScrollController? get scrollController => _scrollController;
  void setScrollController(ScrollController ctrl) {
    _scrollController = ctrl;
  }

  //获取加载指示器的高度
  double Function()? _getLoadWidgetHeight;
  double Function()? get getLoadWidgetHeight => _getLoadWidgetHeight;
  void setFuncGetLoadWidgetHeight(double Function()? func) {
    _getLoadWidgetHeight = func;
  }

  //FunctionList中获取加载的页面的高度
  void Function(double)? _getCurrentPageHeightInFunctionList;
  void Function(double)? get getCurrentPageHeightInFunctionList =>
      _getCurrentPageHeightInFunctionList;
  void setFuncGetCurrentPageHeightInFunctionList(void Function(double)? func) {
    _getCurrentPageHeightInFunctionList = func;
  }

  //FunctionList中将高度加入标记map尾部
  void Function()? _pushHeightPageInFunctionList;
  void Function()? get pushHeightPageInFunctionList =>
      _pushHeightPageInFunctionList;
  void setFuncPushHeightPageInFunctionList(void Function()? func) {
    _pushHeightPageInFunctionList = func;
  }

  //FunctionList中将高度加入标记map头部
  void Function()? _insertHeightPageInFunctionList;
  void Function()? get insertHeightPageInFunctionList =>
      _insertHeightPageInFunctionList;
  void setFuncInsertHeightPageInFunctionList(void Function()? func) {
    _insertHeightPageInFunctionList = func;
  }

  //switchList中删除singleScrollViewItem头部的一项
  void Function()? _removeSingleChildScrollViewItemOnHeadInSwitchList;
  void Function()? get removeSingleChildScrollViewItemOnHeadInSwitchList =>
      _removeSingleChildScrollViewItemOnHeadInSwitchList;
  void setFuncRemoveSingleChildScrollViewOnHeadInSwitchList(
      void Function() func) {
    _removeSingleChildScrollViewItemOnHeadInSwitchList = func;
  }

  //switchList中删除singleScrollViewItem尾部的一项
  void Function()? _removeSingleChildScrollViewItemOnFootInSwitchList;
  void Function()? get removeSingleChildScrollViewItemOnFootInSwitchList =>
      _removeSingleChildScrollViewItemOnFootInSwitchList;
  void setFuncRemoveSingleChildScrollViewOnFootInSwitchList(
      void Function() func) {
    _removeSingleChildScrollViewItemOnFootInSwitchList = func;
  }

  //switchList中删除ListViewItem头部的一项
  void Function()? _removeListViewItemOnHeadInSwitchList;
  void Function()? get removeListViewItemOnHeadInSwitchList =>
      _removeListViewItemOnHeadInSwitchList;
  void setFuncRemoveListViewItemOnHeadInSwitchList(void Function()? func) {
    _removeListViewItemOnHeadInSwitchList = func;
  }

  //switchList中删除ListViewItem尾部的一项
  void Function()? _removeListViewItemOnFootInSwitchList;
  void Function()? get removeListViewItemOnFootInSwitchList =>
      _removeListViewItemOnFootInSwitchList;
  void setFuncRemoveListViewItemOnFootInSwitchList(void Function()? func) {
    _removeListViewItemOnFootInSwitchList = func;
  }

  //维护加载上一个item队列
  void Function()? _maintainItemsInLoadPreInFunctionList;
  void Function()? get maintainItemsInLoadPreInFunctionList =>
      _maintainItemsInLoadPreInFunctionList;
  void setFuncMaintainItemsInLoadPreInFunctionList(void Function()? func) {
    _maintainItemsInLoadPreInFunctionList = func;
  }

  //维护加载更多item队列
  void Function()? _maintainItemsInLoadMoreInFunctionList;
  void Function()? get maintainItemsInLoadMoreFunctionList =>
      _maintainItemsInLoadMoreInFunctionList;
  void setFuncMaintainItemsInLoadMoreInFunctionList(void Function()? func) {
    _maintainItemsInLoadMoreInFunctionList = func;
  }

  //打印调试
  void Function()? _testSignDisplayInFunctionList;
  void Function()? get testSingDisplayInFunctionList =>
      _testSignDisplayInFunctionList;
  void setFuncTestSingDisplayInFunctionList(void Function()? func) {
    _testSignDisplayInFunctionList = func;
  }

  //加载更多时在裁剪item数量时设置scollcontroller
  void Function(double)? _rebuildScrollCrtlLoadMoreMaintainItemsInSwitchList;
  void Function(double)?
      get rebuildScrollCrtlLoadMoreMaintainItemsInSwitchList =>
          _rebuildScrollCrtlLoadMoreMaintainItemsInSwitchList;
  void setFuncRebuildScrollCrtlLoadMoreMaintainItemsInSwitchList(
      void Function(double)? func) {
    _rebuildScrollCrtlLoadMoreMaintainItemsInSwitchList = func;
  }

  //loadMore时在functionList中维护switchList中的滚动条
  void Function()? _maintainScrollCtrlInLoadMoreInFunctionList;
  void Function()? get maintainScrolllCtrlInLoadMoreInFunctionList =>
      _maintainScrollCtrlInLoadMoreInFunctionList;
  void setFuncMaintainScrollCtrlInLoadMoreInFunctionList(
      void Function()? func) {
    _maintainScrollCtrlInLoadMoreInFunctionList = func;
  }

  //switchList中的scrollListener
  void Function()? _scrollListenerInSwitchList;
  void Function()? get scrollListenerInSwitchList =>
      _scrollListenerInSwitchList;
  void setFuncScrollListenerInSwitchList(void Function() func) {
    _scrollListenerInSwitchList = func;
  }

  //switchList中的rebuildScrollCrtlLoadMoreAfter
  void Function()? _rebuildScrollCtrlLoadMoreAfterInSwitchList;
  void Function()? get rebuildScrollCtrlLoadMoreAfterInSwitchList =>
      _rebuildScrollCtrlLoadMoreAfterInSwitchList;
  void setFuncRebuildScrollCtrlLoadMoreAfterInSwitchList(
      void Function()? func) {
    _rebuildScrollCtrlLoadMoreAfterInSwitchList = func;
  }

  //获得FunctionList中的当前页码
  int Function()? _getCurrentPageInFunctionList;
  int Function()? get getCurrentPageInFunctionList =>
      _getCurrentPageInFunctionList;
  void setFuncGetCurrentPageInFunctionList(int Function()? func) {
    _getCurrentPageInFunctionList = func;
  }

  //获得FunctionList中的最大页码
  int Function()? _getMaxPageInFunctionList;
  int Function()? get getMaxPageInFunctionList => _getMaxPageInFunctionList;
  void setFuncGetMaxPageInFunctionList(int Function()? func) {
    _getMaxPageInFunctionList = func;
  }

  //functionList中计算当前页面的方法
  void Function()? _selectPageInFunctionList;
  void Function()? get selectPageInFunctionList => _selectPageInFunctionList;
  void setFuncSelectPageInFunctionList(void Function()? func) {
    _selectPageInFunctionList = func;
  }

  //switchList中修改加载上一个的锁
  void Function(bool)? _setIsLockedLoadPre;
  void Function(bool)? get setIsLockedLoadPre => _setIsLockedLoadPre;
  void setFuncSetIsLockedLoadPre(void Function(bool)? func) {
    _setIsLockedLoadPre = func;
  }

  //switchList中修改加载下一个的锁
  void Function(bool)? _setIsLockedLoadMore;
  void Function(bool)? get setIsLockedLoadMore => _setIsLockedLoadMore;
  void setFuncSetIsLockedLoadMore(void Function(bool)? func) {
    _setIsLockedLoadMore = func;
  }

  //functionList中计算是否锁定加载上一个
  void Function()? _selectIsLockLoadPre;
  void Function()? get selectIsLockLoadPre => _selectIsLockLoadPre;
  void setFuncSetIsLockLoadPre(void Function()? func) {
    _selectIsLockLoadPre = func;
  }

  //functionList中计算是否锁定加载更多
  void Function()? _selectIsLockLoadMore;
  void Function()? get selectIsLockLoadMore => _selectIsLockLoadMore;
  void setFuncSetIsLockLoadMore(void Function()? func) {
    _selectIsLockLoadMore = func;
  }

  //functionList中获得头部起始页页码
  int Function()? _getPageStartIndex;
  int Function()? get getPageStartIndex => _getPageStartIndex;
  void setFuncGetPageStartIndex(int Function()? func) {
    _getPageStartIndex = func;
  }

  //functionList中获得尾部页页码
  int Function()? _getPageEndIndex;
  int Function()? get getPageEndIndex => _getPageEndIndex;
  void setFuncGetPageEndIndex(int Function()? func) {
    _getPageEndIndex = func;
  }

  //页码指示器等外部组件在滚动条监听中运行的方法接口
  void Function()? _scrollListenerFunc;
  void Function()? get scrollListenerFunc => _scrollListenerFunc;
  void setFuncScrollListenerFunc(void Function()? func) {
    _scrollListenerFunc = func;
  }
}
