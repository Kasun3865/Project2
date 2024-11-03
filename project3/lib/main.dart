import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:project3/screens/login_screen.dart';
import 'package:project3/screens/mood_tracking_screen.dart'; // Import the new MoodTrackingScreen
import 'package:project3/models/mood_provider.dart'; // Import MoodProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CalmApp());
}

class CalmApp extends StatelessWidget {
  const CalmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MoodProvider()), // Register the MoodProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calm Mental Health App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LoginScreen(),
        routes: {
          '/mood-tracking': (context) =>
              MoodTrackingScreen(), // Define a route for the MoodTrackingScreen
          // Add other routes here if needed
        },
      ),
    );
  }
}
