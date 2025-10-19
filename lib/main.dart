import 'package:flutter/material.dart';
import 'package:subterfuge/features/home/page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subterfuge',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
