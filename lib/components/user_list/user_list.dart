import 'package:flutter/material.dart';
import '../double_bladed_axe/double_bladed_axe.dart';
import '../util/util.dart';

//用于http请求和包装好生成的组件列表，这个组件将由用户创建
class UserList extends StatefulWidget {
  final LessonListUtil lessonListUtil;
  final double height;
  final String initPage;
  final String pageMaxContainCount;
  final String maxPage;
  const UserList({
    super.key,
    required this.lessonListUtil,
    required this.height,
    required this.initPage,
    required this.pageMaxContainCount,
    required this.maxPage,
  });
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late int initPage;
  late int pageMaxContainCount;
  late int maxPage;
  List<Widget> initWidgets = [];
  int testCount = 0;
  @override
  void initState() {
    super.initState();
    //注册方法
    widget.lessonListUtil.setFuncGetLoadMoreWidgets(loadMore);
    widget.lessonListUtil.setFuncGetLoadPreWidgets(loadPre);
    widget.lessonListUtil.setScreenHeight(widget.height);
    //初始化
    initPage = int.tryParse(widget.initPage)!;
    pageMaxContainCount = int.tryParse(widget.pageMaxContainCount)!;
    maxPage = int.tryParse(widget.maxPage)!;
    initItem();
  }

  @override
  Widget build(BuildContext context) {
    widget.lessonListUtil.setScreenHeight(widget.height);
    return DoubleBladedAxe(
      initWidgets: initWidgets,
      initPage: widget.initPage,
      maxPage: widget.maxPage,
      pageMaxContainCount: widget.pageMaxContainCount,
      lessonListUtil: widget.lessonListUtil,
    );
  }

  //利用viewModel进行Http请求
  Future<List<Widget>> loadPre() async {
    List<Widget> widgets = List.generate(5, (index) {
      return Text('请求上一页数据位置');
    });
    return widgets;
  }

  //利用viewModel进行Http请求
  Future<List<Widget>> loadMore() async {
    List<Widget> widgets = List.generate(5, (index) {
      return Text('请求更多数据位置');
    });
    return widgets;
  }

  void initItem() {
    initWidgets = List.generate(5, (index) {
       return Text('初始化数据位置');
    });
  }
}
