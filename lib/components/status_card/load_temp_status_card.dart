import 'package:flutter/material.dart';
import '../util/util.dart';


//包装加载指示器以便获得高度

class LoadTemp extends StatefulWidget {
  final Widget  loadWidget;
  final LessonListUtil lessonListUtil;
  const LoadTemp({super.key, required this.loadWidget, required this.lessonListUtil});

  @override
  State<LoadTemp> createState() => _LoadTempState();
}

class _LoadTempState extends State<LoadTemp> {
  late GlobalKey key;

  @override
  void initState() {
    super.initState();
    key = GlobalKey();
    widget.lessonListUtil.setFuncGetLoadWidgetHeight(getHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      key: key,
      builder: (context){
        return widget.loadWidget;
    });
  }

  double getHeight(){
    return key.currentContext!.size!.height;
  }
}