import 'package:flutter/material.dart';
import '../../util.dart';
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
  final ListUtil listUtil;
  const DoubleBladedAxe({
    super.key,
    this.loadMoreStatusWidget,
    this.loadPreStatusWidget,
    required this.initWidgets,
    required this.initPage,
    required this.maxPage,
    required this.pageMaxContainCount,
    required this.listUtil,
  });
  @override
  State<DoubleBladedAxe> createState() => _DoubleBladedAxeState();
}

class _DoubleBladedAxeState extends State<DoubleBladedAxe> {
  @override
  Widget build(BuildContext context) {
    return FunctionList(
        initListItems: widget.initWidgets,
        listUtil: widget.listUtil,
        initPage: widget.initPage,
        maxPage: widget.maxPage,
        pageMaxContainCount: widget.pageMaxContainCount,
        loadMoreStatusWidget: widget.loadMoreStatusWidget ??
            UserLoadMoreWidget(listUtil: widget.listUtil),
        loadPreStatusWidget: widget.loadPreStatusWidget ??
            UserLoadPreWidget(listUtil: widget.listUtil));
  }
}
