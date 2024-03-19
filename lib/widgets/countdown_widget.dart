import 'dart:async';

import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  Duration duration;
  CountDownWidget({required this.duration, super.key});

  @override
  State<CountDownWidget> createState() => CountDownWidgetState();
}

class CountDownWidgetState extends State<CountDownWidget> {
  Timer? timer;
  // Define a variable to store the current countdown value
  int _countdownValue = 0;

  @override
  void initState() {
    super.initState();
    // Start the countdown timer
    startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    timer?.cancel();
    super.dispose();
  }

  // Method to start the countdown timer
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.duration.inSeconds < 0) {
        // Countdown is finished
        timer?.cancel();
        // Perform any desired action when the countdown is completed
      } else {
        // Update the countdown value and decrement by 1 second
        _countdownValue = widget.duration.inSeconds;
        widget.duration = widget.duration - Duration(seconds: 1);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Time Left : $_countdownValue');
  }
}
