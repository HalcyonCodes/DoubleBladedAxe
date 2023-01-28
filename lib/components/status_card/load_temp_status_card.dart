import 'package:flutter/material.dart';
import '../../util.dart';

//包装加载指示器以便获得高度

class LoadTemp extends StatefulWidget {
  final Widget loadWidget;
  final ListUtil listUtil;
  const LoadTemp({super.key, required this.loadWidget, required this.listUtil});

  @override
  State<LoadTemp> createState() => _LoadTempState();
}

class _LoadTempState extends State<LoadTemp> {
  late GlobalKey key;

  @override
  void initState() {
    super.initState();
    key = GlobalKey();
    widget.listUtil.setFuncGetLoadWidgetHeight(getHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        key: key,
        builder: (context) {
          return widget.loadWidget;
        });
  }

  double getHeight() {
    return key.currentContext!.size!.height;
  }
}
