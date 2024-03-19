import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/countdown_widget.dart';

class MainScreen extends StatefulWidget {
  Duration duration = Duration(seconds: 3);
  MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int point = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.withOpacity(0.2),
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text('Your Point : $point'),
                CountDownWidget(duration: widget.duration),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  widget.duration = Duration(seconds: 3);
                  CountDownWidgetState().startTimer();
                  setState(() {});
                },
                child: Text('set time'))
          ],
        ),
      ),
    );
  }
}
