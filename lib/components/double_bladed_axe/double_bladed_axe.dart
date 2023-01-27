import 'package:flutter/material.dart';
import '../util/util.dart';
import '../function_list/function_list.dart';
import '../status_card/user_loadmore_widget.dart';
import '../status_card/user_loadpre_widget.dart';

class DoubleBladedAxe extends StatefulWidget {
  final Widget? loadMoreStatusWidget;
  final Widget? loadPreStatusWidget;
  final List<Widget> initWidgets;
  final String initPage;
  final String maxPage;
  final String pageMaxContainCount;
  final LessonListUtil lessonListUtil;
  const DoubleBladedAxe({
    super.key,
    this.loadMoreStatusWidget,
    this.loadPreStatusWidget,
    required this.initWidgets,
    required this.initPage,
    required this.maxPage,
    required this.pageMaxContainCount,
    required this.lessonListUtil,
  });
  @override
  State<DoubleBladedAxe> createState() => _DoubleBladedAxeState();
}

class _DoubleBladedAxeState extends State<DoubleBladedAxe> {
  @override
  Widget build(BuildContext context) {
    return FunctionList(
        initListItems: widget.initWidgets,
        lessonListUtil: widget.lessonListUtil,
        initPage: widget.initPage,
        maxPage: widget.maxPage,
        pageMaxContainCount: widget.pageMaxContainCount,
        loadMoreStatusWidget: widget.loadMoreStatusWidget ??
            UserLoadMoreWidget(lessonListUtil: widget.lessonListUtil),
        loadPreStatusWidget: widget.loadPreStatusWidget ??
            UserLoadPreWidget(lessonListUtil: widget.lessonListUtil));
  }
}
