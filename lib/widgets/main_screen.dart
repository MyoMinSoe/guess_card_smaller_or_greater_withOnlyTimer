import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/countdown_widget.dart';
import 'package:guess_card_smaller_or_greater/widgets/flip_card.dart';

class MainScreen extends StatefulWidget {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Your Point : $point',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple,
              ),
            ),
            PeriodicTimerWidget(
                point: point,
                onCountChange: (int pt) {
                  point = pt;
                  setState(() {});
                }),
            FlipCardAndButton(
                point: point,
                onCheck: (int p) {
                  point += p;
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }
}
