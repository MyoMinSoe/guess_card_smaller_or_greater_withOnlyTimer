import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/game_play_screen.dart';

class MenuScreen extends StatelessWidget {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange, Colors.red, Colors.blue],
        ),
      ),
      child: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.amberAccent.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              textAlign: TextAlign.center,
              controller: textEditingController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GamePlayScreen(),
                      settings: RouteSettings(
                        arguments: textEditingController.text,
                      ),
                    ),
                  );
                },
                child: Text('START'))
          ],
        ),
      ),
    );
  }
}
