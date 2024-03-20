import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/game_play_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final textEditingController = TextEditingController();

  final GlobalKey<FormState> formController = GlobalKey();

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
        child: Form(
          key: formController,
          child: Column(
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Enter Your Win Point...',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  style: TextStyle(fontSize: 30),
                  keyboardType: TextInputType.number,
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
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 1) {
                      return 'Point must be at least 1';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (formController.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GamePlayScreen(),
                        settings: RouteSettings(
                          arguments: textEditingController.text,
                        ),
                      ),
                    );
                  }
                  setState(() {});
                },
                child: const Text(
                  'START',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
