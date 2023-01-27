import 'package:flutter/material.dart';
import '../util/util.dart';


//在singleChildScrollView里创建过度的列表以便于计算页面的坐标，计算完成后切换成ListItem;
class PageTemp extends StatefulWidget {
  final List<Widget> pageWidgets;
  final LessonListUtil lessonListUtil;
  const PageTemp({super.key ,required this.pageWidgets, required this.lessonListUtil});

  @override
  State<PageTemp> createState() => _PageTempState();
}

class _PageTempState extends State<PageTemp> {
  late GlobalKey globalKey;

  @override
  void initState() {
    super.initState();
    globalKey = GlobalKey();
    widget.lessonListUtil.setFuncGetSinglePageHeight(getSinglePageHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.pageWidgets,
      ),
    );
  }

  Future<double> getSinglePageHeight() async {
     return globalKey.currentContext!.size!.height;
  }


}