import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 251, 17, 0),
          title: const Text('Material App Bar'),
        ),
        body: MainScreen(),
      ),
    );
  }
}
