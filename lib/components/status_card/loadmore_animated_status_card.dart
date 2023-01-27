
import 'package:flutter/material.dart';
import 'status_card.dart';

class LoadMoreAnimatedStatusCard extends StatefulWidget {
  final String statusString;
  final AnimationController animationController;
  final Animation<double> animation; 
  const LoadMoreAnimatedStatusCard({super.key, required this.animationController, required this.animation, required this.statusString});

  @override
  State<LoadMoreAnimatedStatusCard> createState() => _LoadMoreAnimatedStatusCardState();

}

class _LoadMoreAnimatedStatusCardState extends State<LoadMoreAnimatedStatusCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context,child){
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0, 
              30 * (1.0 - widget.animation.value), 
              0.0),
            child: StatusCard(status: widget.statusString,),
          ),
        );
      },
    );
  }


}