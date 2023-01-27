import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String status;
  const StatusCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 37,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            color: const Color(0xFFB0CCE1).withOpacity(0.32),
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(status,
              style: const TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(252, 110, 32, 1.0),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
                height: 13 / 13,
              ))
        ],
      ),
    );
  }
}
