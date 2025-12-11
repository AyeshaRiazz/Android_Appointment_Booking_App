import 'package:appointment_booking_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // Uncomment if using FlutterFire CLI
import 'home_screen.dart';
// NOTE: Ensure the path below is correct for your project
import 'package:appointment_booking_app/firebase_auth_service.dart';

void main() async {
  // 1. MUST CALL THIS FIRST: Ensures asynchronous calls work before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Firebase Core
  try {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform, // Uncomment if using FlutterFire CLI
    );
    print("Firebase initialized successfully!");
  } catch (e) {
    print("FATAL Firebase initialization error: $e");
    // You should handle errors gracefully here in a production app
  }

  // 3. Run your app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slotly App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Assuming HomeScreen is your entry point
      home: SplashScreen(),
    );
  }
}