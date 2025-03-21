import 'package:flutter/material.dart';
import 'navigation_bar.dart'; // Import the file with the nav bar code

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regi Master',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomeScreen(), // Use the HomeScreen widget defined in bottom_nav_bar.dart
    );
  }
}