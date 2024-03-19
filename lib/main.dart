import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flip Card',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 12, 0, 67),
          foregroundColor: Colors.white,
          title: const Text('Flip Card'),
        ),
        body: MainScreen(),
      ),
    );
  }
}
