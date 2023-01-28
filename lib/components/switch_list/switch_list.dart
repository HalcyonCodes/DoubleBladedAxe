import 'dart:math';
import 'package:flutter/material.dart';
import '../../util.dart';
import '../page_temp/page_temp.dart';
import '../util/status_util.dart';
import '../status_card/load_temp_status_card.dart';

//在两个滚动条之间切换滚动条并记录翻页组件
//主要任务是在Listview和singlechildScrollView之间切换和获取新添加的页面在滚动条的高度信息

class SwitchList extends StatefulWidget {
  final ListUtil listUtil;
  final List<Widget> initListItems;
  final Widget loadMoreStatusWidget;
  final Widget loadPreStatusWidget;
  const SwitchList(
      {super.key,
      required this.listUtil,
      required this.initListItems,
      required this.loadMoreStatusWidget,
      required this.loadPreStatusWidget});

  @override
  State<SwitchList> createState() => _SwitchListState();
}

class _SwitchListState<T> extends State<SwitchList> {
  late ScrollController scrollController;
  late bool isListView; //切换列表状态指示器
  late bool isLockScroll; //是否锁住列表滚动
  late Widget? singleChildScrollViewItemTemp; //添加用于计算长度的元件
  late bool isLockedLoadPre; //锁定加载上一个
  late bool isLockedLoadMore; //锁定加载下一个

  List<Widget> listViewItems = []; //用于显示的列表Items
  List<Widget> singleChildScrollViewItems = []; //用于计算的列表Items
  List<Widget> widgetsTemp = []; //用于存放上一层http请求后得到的组件

  @override
  void initState() {
    super.initState();
    //注册方法
    widget.listUtil
        .setFuncRemoveListViewItemOnHeadInSwitchList(removeListViewItemOnHead);
    widget.listUtil
        .setFuncRemoveListViewItemOnFootInSwitchList(removeListViewItemOnFoot);
    widget.listUtil.setFuncRemoveSingleChildScrollViewOnFootInSwitchList(
        removeSingleChildScrollViewItemOnFoot);
    widget.listUtil.setFuncRemoveSingleChildScrollViewOnHeadInSwitchList(
        removeSingleChildScrollViewItemOnHead);
    widget.listUtil
        .setFuncRebuildScrollCrtlLoadMoreMaintainItemsInSwitchList(
            rebuildScrollCrtlLoadMoreMaintainItems);
    widget.listUtil.setFuncScrollListenerInSwitchList(scrollListener);
    widget.listUtil.setFuncRebuildScrollCtrlLoadMoreAfterInSwitchList(
        rebuildScrollCrtlLoadMoreAfter);
    widget.listUtil.setFuncSetIsLockedLoadMore(setIsLockedLoadMore);
    widget.listUtil.setFuncSetIsLockedLoadPre(setIsLockedLoadPre);

    isListView = true;
    isLockScroll = false;
    isLockedLoadMore = false;
    isLockedLoadPre = false;
    scrollControllerInit();
    singleChildScrollViewItemTemp = PageTemp(
        pageWidgets: widget.initListItems,
        listUtil: widget.listUtil); //初始化用于计算长度的元件
    addSingleChildScrollViewItemOnFoot(
        singleChildScrollViewItemTemp!); //添加到SingleChildScrollViewItem列表里，用于切换显示然后计算长度
    addListViewItemOnFoot(singleChildScrollViewItemTemp!); //初始化列表元件
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isListView
          ? ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                key: Key(listViewItems.length.toString() +
                    Random().nextInt(9999).toString()),
                physics: isLockScroll
                    ? const NeverScrollableScrollPhysics()
                    : const ClampingScrollPhysics(),
                shrinkWrap: true,
                controller: scrollController,
                children: listViewItems,
              ),
            )
          : ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: isLockScroll
                    ? const NeverScrollableScrollPhysics()
                    : const ClampingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: singleChildScrollViewItems),
              ),
            ),
    );
  }

  void refreshUi() async {
    setState(() {});
  }

  void setIsListView(bool b) async {
    isListView = b;
  }

  //在ListViewItem头部添加元件
  void addListViewItemOnHead(items) {
    listViewItems.insert(0, items);
  }

  //在ListViewItem尾部添加元件
  void addListViewItemOnFoot(Widget items) {
    listViewItems.add(items);
  }

  //在SingleChildScrollView头部添加元件
  void addSingleChildScrollViewItemOnHead(Widget item) {
    singleChildScrollViewItems.insert(0, item);
  }

  //在SingleChildScrollVIew尾部添加元件
  void addSingleChildScrollViewItemOnFoot(Widget item) {
    singleChildScrollViewItems.add(item);
  }

  //在SingleChildScrollView中删除最后的widgetTemp并把所有item添加进去
  void rebuildSingleChildScrollViewItemOnFoot(Widget item) {
    singleChildScrollViewItems.removeLast();
    singleChildScrollViewItems.add(item);
  }

  //在SingleChildScrollView中删除尾部元件并把所有item添加到头部
  void rebuildSingleChildScrollViewItemOnHead(Widget item) {
    singleChildScrollViewItems.removeLast();
    singleChildScrollViewItems.insert(0, item);
  }

  //在ListViewItem头部删除元件
  void removeListViewItemOnHead() {
    listViewItems.removeAt(0);
  }

  //在ListViewItem尾部删除元件
  void removeListViewItemOnFoot() {
    listViewItems.removeLast();
  }

  //在singleChildScrollView头部删除元件
  void removeSingleChildScrollViewItemOnHead() {
    singleChildScrollViewItems.removeAt(0);
  }

  //在singleChildScrollView尾部删除元件
  void removeSingleChildScrollViewItemOnFoot() {
    singleChildScrollViewItems.removeLast();
  }

  //在SingleChildScrollView头部添加加载进度指示器
  void addLoadPreStatusCardOnHead() {
    listViewItems.insert(0, widget.loadPreStatusWidget);
  }

  //在SingleChildScrollView尾部添加加载进度指示器
  void addLoadMoreStatusCardOnFoot() {
    listViewItems.add(widget.loadMoreStatusWidget);
  }

  //在SingleChildScrollView头部移除加载进度指示器
  void removeLoadPreStatusCardOnHead() {
    listViewItems.removeAt(0);
  }

  //在SingleChildScrollView尾部移除加载进度指示器
  void removeLoadMoreStatusCardOnFoot() {
    listViewItems.removeLast();
  }

  //监控滚动条
  void scrollListener() {
    scrollController.addListener(() async {
      if (widget.listUtil.status == Status.statusIdel) {
        widget.listUtil.selectIsLockLoadMore!();
        widget.listUtil.selectIsLockLoadPre!();
      }

      //判断当前进度条位于哪
      if (widget.listUtil.status == Status.statusIdel) {
        widget.listUtil.selectPageInFunctionList!();
      }
      //判断加载上一页和加载下一页
      if (widget.listUtil.status == Status.statusIdel) {
        //滚动条的最大值超过页面的高度
        if (scrollController.position.maxScrollExtent != 0 &&
            scrollController.position.minScrollExtent == 0) {
          //判断是否可以拖动
          if (widget.listUtil.status == Status.statusIdel) {
            //下拉判断
            if ((scrollController.position.pixels ==
                    scrollController.position.minScrollExtent) &&
                (!isLockedLoadPre)) {
              widgetsTemp = [];
              singleChildScrollViewItemTemp = null;
              widget.listUtil
                  .setStatus(Status.statusHeadLoading); //设置状态为非空闲
              //double originPixel = scrollController.position.maxScrollExtent; //获得没有添加进度指示器时的高度
              setIsListView(true);
              addLoadPreStatusCardOnHead(); //在头部添加加载指示器
              rebuildScrollCtrlLoadPreBefore();

              refreshUi(); //切换成SinglechiScrollView
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                widget.listUtil.startLoadPreStatusCardAniamte!(() async {
                  try {
                    widgetsTemp = await widget
                        .listUtil.getLoadPreWidgets!(); //http请求并组装组件
                    //反向播放动画
                    await widget
                        .listUtil.reversetLoadPreStatusCardAniamte!(() {
                      //修改加载指示器
                      Widget loadCard = widget.loadPreStatusWidget;
                      Widget loadTemp = LoadTemp(
                          loadWidget: loadCard,
                          listUtil: widget.listUtil);
                      //在singlechildscrollview的Item头部添加指示器
                      addSingleChildScrollViewItemOnHead(loadTemp);
                      singleChildScrollViewItemTemp = PageTemp(
                          pageWidgets: widgetsTemp,
                          listUtil: widget.listUtil);
                      addSingleChildScrollViewItemOnFoot(
                          singleChildScrollViewItemTemp!);
                      setIsListView(false); //切换成singlechild
                      rebuildScrollCtrlLoadPreBefore();
                      refreshUi();
                      WidgetsBinding.instance
                          .addPostFrameCallback((timeStamp) async {
                        //测出组件高度
                        double pageHeight =
                            await widget.listUtil.getSinglePageHeight!();
                        //测出加载指示器的高度
                        double loadHeight =
                            widget.listUtil.getLoadWidgetHeight!();
                        //!!--添加页面计算单元----
                        //删除在头部添加的指示器装饰
                        singleChildScrollViewItems.removeAt(0);
                        //删除在尾部添加的临时widget
                        rebuildSingleChildScrollViewItemOnHead(
                            singleChildScrollViewItemTemp!);
                        removeLoadPreStatusCardOnHead(); //在listview头部删除指示器
                        addListViewItemOnHead(
                            singleChildScrollViewItemTemp); //listview头部添加展示组件
                        //设置成listview
                        setIsListView(true);
                        rebuildScrollCrtlLoadPreAfter(pageHeight - loadHeight);
                        //====计算并维护卡片队列===
                        widget.listUtil
                            .getCurrentPageHeightInFunctionList!(pageHeight);
                        widget.listUtil
                            .maintainItemsInLoadPreInFunctionList!();
                        widget.listUtil.insertHeightPageInFunctionList!();
                        //打印调试
                        //widget.lessonListUtil.testSingDisplayInFunctionList!();
                        //====
                        refreshUi();
                        widget.listUtil.setStatus(Status.statusIdel);
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          widget.listUtil.selectPageInFunctionList!();
                        });
                      });
                    });
                  } catch (e) {
                    widget.listUtil
                        .setStatus(Status.statusFootLoadFaild); //设置状态
                    singleChildScrollViewItemTemp = null; //
                    widgetsTemp = [];
                    await widget
                        .listUtil.reversetLoadMoreStatusCardAniamte!(() {
                      removeLoadMoreStatusCardOnFoot();
                      rebuildScrollCrtlLoadMoreAfter();
                      setIsListView(true);
                      refreshUi();
                      widget.listUtil.setStatus(Status.statusIdel);
                    });
                  }
                });
              });
              return;
            }

            //上拉判断
            if ((scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent) &&
                (!isLockedLoadMore)) {
              widgetsTemp = [];
              singleChildScrollViewItemTemp = null;
              widget.listUtil
                  .setStatus(Status.statusFootLoading); //设置状态为非空闲
              setIsListView(true); //切换到
              addLoadMoreStatusCardOnFoot(); //在尾部添加加载指示器
              rebuildScrollCrtlLoadMoreBefore(); //从新构建滚scrollController
              refreshUi();
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                widget.listUtil.startLoadMoreStatusCardAniamte!(() async {
                  try {
                    widgetsTemp = await widget
                        .listUtil.getLoadMoreWidgets!(); //http请求并组装组件
                    //反向播放动画
                    await widget
                        .listUtil.reversetLoadMoreStatusCardAniamte!(() {
                      removeLoadMoreStatusCardOnFoot();

                      singleChildScrollViewItemTemp = PageTemp(
                          pageWidgets: widgetsTemp,
                          listUtil: widget.listUtil);
                      addSingleChildScrollViewItemOnFoot(
                          singleChildScrollViewItemTemp!); //添加Item
                      rebuildScrollCrtlLoadMoreBefore();
                      setIsListView(false);
                      refreshUi(); //刷新ui

                      WidgetsBinding.instance
                          .addPostFrameCallback((timeStamp) async {
                        //计算页面高度
                        double pageHeight =
                            await widget.listUtil.getSinglePageHeight!();
                        addListViewItemOnFoot(singleChildScrollViewItemTemp!);
                        //设置成listview
                        setIsListView(true);
                        //删除singleChildScrollView中最后一个元素，添加请求的item；
                        rebuildSingleChildScrollViewItemOnFoot(
                            singleChildScrollViewItemTemp!);
                        //====维护卡片队列====
                        widget.listUtil
                            .getCurrentPageHeightInFunctionList!(pageHeight);
                        widget.listUtil
                            .maintainItemsInLoadMoreFunctionList!();
                        widget.listUtil
                            .maintainScrolllCtrlInLoadMoreInFunctionList!();
                        //这里有顺序，需要先计算和维护好item和scrollview后才把位置加入位置标记里
                        widget.listUtil.pushHeightPageInFunctionList!();
                        //打印调试
                        //widget.lessonListUtil.testSingDisplayInFunctionList!();
                        refreshUi();
                        widget.listUtil.setStatus(Status.statusIdel);
                      });
                    });
                  } catch (e) {
                    widget.listUtil
                        .setStatus(Status.statusFootLoadFaild); //设置状态
                    singleChildScrollViewItemTemp = null; //
                    widgetsTemp = [];
                    await widget
                        .listUtil.reversetLoadMoreStatusCardAniamte!(() {
                      removeLoadMoreStatusCardOnFoot();
                      rebuildScrollCrtlLoadMoreAfter();
                      setIsListView(true);
                      refreshUi();
                      widget.listUtil.setStatus(Status.statusIdel);
                      
                    });
                  }
                });
              });
              return;
            }
          }
        }
      }
    });
  }

  //初始化scrollController
  void scrollControllerInit() {
    scrollController = ScrollController(initialScrollOffset: 2);
    widget.listUtil.setScrollController(scrollController);
    scrollListener();
  }

  //加载完成后最后一步切换成listview用的scrollerController
  void rebuildScrollCrtlLoadMoreAfter() {
    double currentPixel = scrollController.position.pixels;
    scrollController = ScrollController(initialScrollOffset: currentPixel);
    widget.listUtil.setScrollController(scrollController);
    scrollListener();
  }

  //加载更多时第一次切换成singleChildScrollView所用的scrollCOntroller
  void rebuildScrollCrtlLoadMoreBefore() {
    double currentPixel = scrollController.position.pixels;
    scrollController = ScrollController(initialScrollOffset: currentPixel);
    widget.listUtil.setScrollController(scrollController);
  }

  //加载上一个时第一次切换,
  void rebuildScrollCtrlLoadPreBefore() {
    double currentPixel = 0;
    scrollController = ScrollController(initialScrollOffset: currentPixel);
    widget.listUtil.setScrollController(scrollController);
  }

  //加载上一个后切换成listview的Scrollview
  void rebuildScrollCrtlLoadPreAfter(double pixel) {
    scrollController = ScrollController(initialScrollOffset: pixel);
    widget.listUtil.setScrollController(scrollController);
    scrollListener();
  }

  //加载上一个时在切换成singlechilScrollview时使用的scrollview
  void rebuildScrollCrtlLoadPreMid(double pixel) {
    scrollController = ScrollController(initialScrollOffset: pixel);
    widget.listUtil.setScrollController(scrollController);
  }

  //加载更多时，裁剪item数量后，重新构建scrollController
  void rebuildScrollCrtlLoadMoreMaintainItems(double pixel) {
    double currentPixel = scrollController.position.pixels;
    double p = currentPixel - pixel;
    scrollController = ScrollController(initialScrollOffset: p);
    widget.listUtil.setScrollController(scrollController);
  }

  //修改是否锁定加载上一个
  void setIsLockedLoadPre(bool b) {
    isLockedLoadPre = b;
  }

  //修改是否加锁定载下一个
  void setIsLockedLoadMore(bool b) {
    isLockedLoadMore = b;
  }
}
