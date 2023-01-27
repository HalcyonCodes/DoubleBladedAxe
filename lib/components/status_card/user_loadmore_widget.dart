import 'package:flutter/material.dart';
import 'loadmore_status_interface.dart';
import 'loadmore_animated_status_card.dart';
import '../util/util.dart';

class UserLoadMoreWidget extends StatefulWidget {
  final LessonListUtil lessonListUtil;
  const UserLoadMoreWidget({super.key, required this.lessonListUtil});

  @override
  State<UserLoadMoreWidget> createState() => _UserLoadMoreWidgetState();
}

class _UserLoadMoreWidgetState extends State<UserLoadMoreWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LoadMoreStatusInterface(
        lessonListUtil: widget.lessonListUtil,
        animationController: animationController,
        widget: LoadMoreAnimatedStatusCard(
            animationController: animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 3) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            statusString: widget.lessonListUtil.statusText));
  }
}
