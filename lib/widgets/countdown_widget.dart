import 'dart:async';

import 'package:flutter/material.dart';

class PeriodicTimerWidget extends StatefulWidget {
  final int point;
  final Function(int) onCountChange;
  const PeriodicTimerWidget({
    super.key,
    required this.point,
    required this.onCountChange,
  });
  @override
  _PeriodicTimerWidgetState createState() => _PeriodicTimerWidgetState();
}

class _PeriodicTimerWidgetState extends State<PeriodicTimerWidget> {
  Timer? periodicTimer;
  int timecount = 10;

  void startPeriodicTimer() {
    periodicTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timecount == 0) {
        widget.onCountChange(-1);

        periodicTimer?.cancel();
      } else {
        timecount--;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    periodicTimer?.cancel();

    super.dispose();
  }

  @override
  void initState() {
    startPeriodicTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Time Left - ',
          style: TextStyle(
            color: Colors.red,
            fontSize: 40,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Icon(
          Icons.timelapse,
          size: 50,
          color: Colors.red,
        ),
        Text(
          '00:0$timecount',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
