
import 'package:flutter/material.dart';
import './status_card.dart';

class LoadPreAnimatedStatusCard extends StatefulWidget {
  final String statusString;
  final AnimationController animationController;
  final Animation<double> animation; 
  const LoadPreAnimatedStatusCard({super.key, required this.animationController, required this.animation, required this.statusString});

  @override
  State<LoadPreAnimatedStatusCard> createState() => _LoadPreAnimatedStatusCardState();

}

class _LoadPreAnimatedStatusCardState extends State<LoadPreAnimatedStatusCard> {

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
              30 * (widget.animation.value - 1.0), 
              0.0),
            child: StatusCard(status: widget.statusString,),
          ),
        );
      },
    );
  }


}