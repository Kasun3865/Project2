import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project3/screens/login_screen.dart';
// You will create this later

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CalmApp());
}

class CalmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calm Mental Health App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}
