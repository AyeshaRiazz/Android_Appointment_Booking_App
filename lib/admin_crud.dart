import 'package:flutter/material.dart';

class AdminCrudScreen extends StatelessWidget {
  const AdminCrudScreen({super.key});

  // Theme colors to match your app
  final Color primaryColor = const Color(0xFFED7D6D); // Coral
  final Color secondaryColor = const Color(0xFF6AB1AB); // Teal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 80, color: primaryColor),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Admin CRUD Panel",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "User authentication successful.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            // You can add a Sign Out button here later
          ],
        ),
      ),
    );
  }
}