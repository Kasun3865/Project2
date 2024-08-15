import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(CalmApp());
}

class CalmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calm Mental Health App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
