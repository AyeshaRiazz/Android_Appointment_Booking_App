import 'package:flutter/material.dart';
import 'package:appointment_booking_app/adminLogin.dart';

class HomeScreen extends StatelessWidget {
  // Main theme colors
  final Color primaryColor = Color(0xFFED7D6D); // Coral
  final Color secondaryColor = Color(0xFF6AB1AB); // Teal
  final Color primaryLight = Color(0xFFF9E7E5);
  final Color secondaryLight = Color(0xFFD8F0EE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // TOP NAVIGATION BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Slotly",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // ⭐ ADMIN BUTTON: NOW NAVIGATES ⭐
          _loginButton("Admin", context, primaryColor, () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AdminLoginScreen()),
            );
          }),

          // PATIENT BUTTON: No navigation yet, as requested
          _loginButton("Patient", context, secondaryColor, () {
            // Patient login logic will go here later
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Patient login screen coming soon!')),
            );
          }),
          SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ⭐ REVISED CENTERED HERO SECTION ⭐
            Container(
              // **Adjustment 1: Added Top Padding to Body Content**
              // This acts as the visual space you requested below the AppBar.
              padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: primaryLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hero Image
                  // **Adjustment 2: Increased Image Size**
                  Image.asset(
                    "assets/doctor.png", // Ensure this asset path is correct
                    width: 250, // Made it larger
                    height: 250, // Made it larger
                    fit: BoxFit.contain,
                  ),

                  // **Adjustment 3: Reduced Space between Image and Tagline**
                  SizedBox(height: 15),

                  // Tagline
                  Text(
                    "Book Smarter", // First line
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    "Live Healthier", // Second line
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: secondaryColor,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 15),

                  // Descriptive Line
                  Text(
                    "Schedule appointments with top doctors quickly and easily. Your wellness journey starts here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                  SizedBox(height: 25),

                  // Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "Find a Doctor",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // ⭐ ABOUT APP ⭐
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _sectionTitle("About HealthConnect", primaryColor),
                  SizedBox(height: 10),
                  Text(
                    "HealthConnect is your bridge to better health. Patients can seamlessly browse doctors, check real-time availability, and manage appointments with a few taps. Administrators have dedicated tools to manage records, update schedules, and oversee the entire booking ecosystem.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // ⭐ MEET OUR TEAM ⭐
            _sectionTitle("Meet Our Featured Doctors", secondaryColor),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _teamCard("Dr. Sarah", "Cardiologist", "assets/doctor.png"),
                  _teamCard("Dr. Ahmed", "Orthopedic", "assets/doctor.png"),
                  _teamCard("Dr. Maria", "Dermatologist", "assets/doctor.png"),
                ],
              ),
            ),

            SizedBox(height: 40),

            // Divider for visual separation
            Divider(color: primaryLight, thickness: 8),

            SizedBox(height: 20),

            // ⭐ FAQ SECTION ⭐
            _sectionTitle("Frequently Asked Questions", primaryColor),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _faqTile("How do I book an appointment?",
                      "Simply register as a patient, choose a doctor, and select an available time slot. Confirmation will be sent immediately.", secondaryColor),
                  _faqTile("Is booking free?",
                      "Yes, using the HealthConnect platform to book and manage appointments is completely free for patients.", secondaryColor),
                  _faqTile("How do I register as an admin?",
                      "Admin accounts are exclusively provisioned by the system administrators for authorized personnel.", secondaryColor),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ⭐ FOOTER ⭐
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withOpacity(0.9), secondaryColor.withOpacity(0.9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "© 2025 HealthConnect. All rights reserved.",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Contact: support@healthconnect.com",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for AppBar Login Buttons
  Widget _loginButton(String text, BuildContext context, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _sectionTitle(String title, Color color) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  // TEAM CARD WIDGET
  Widget _teamCard(String name, String role, String imgPath) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: primaryLight,
              child: Image.asset(imgPath, width: 60, height: 60),
            ),
            SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 2),
            Text(
              role,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // FAQ TILE
  Widget _faqTile(String title, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryLight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(
                desc,
                style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}