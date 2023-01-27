import 'package:flutter/material.dart';
import '../util/util.dart';
import './loadpre_status_interface.dart';
import 'loadpre_animated_status_card.dart';

class UserLoadPreWidget extends StatefulWidget {
  final LessonListUtil lessonListUtil;
  const UserLoadPreWidget({super.key, required this.lessonListUtil});

  @override
  State<UserLoadPreWidget> createState() => _UserLoadPreWidgetState();
}

class _UserLoadPreWidgetState extends State<UserLoadPreWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    return LoadPreStatusInterface(
        lessonListUtil: widget.lessonListUtil,
        animationController: animationController,
        widget: LoadPreAnimatedStatusCard(
            animationController: animationController,
            animation: Tween<double>(begin: 0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 3) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            statusString: widget.lessonListUtil.statusText));
  }
}
