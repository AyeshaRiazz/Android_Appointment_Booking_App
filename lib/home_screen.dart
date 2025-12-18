import 'package:flutter/material.dart';
import 'package:appointment_booking_app/adminLogin.dart';
import 'PatientLoginScreen.dart';

class HomeScreen extends StatelessWidget {
  // Main theme colors
  final Color primaryColor = Color(0xFFED7D6D); // Coral
  final Color secondaryColor = Color(0xFF6AB1AB); // Teal
  final Color primaryLight = Color(0xFFF9E7E5);
  final Color secondaryLight = Color(0xFFD8F0EE);
  final Color backgroundColor = Color(0xFFFAFAFA);
  final Color textColor = Color(0xFF333333);
  final Color subtleGray = Color(0xFF666666);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // IMPROVED TOP NAVIGATION BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Row(
          children: [
            Icon(Icons.medical_services_outlined, color: primaryColor, size: 28),
            SizedBox(width: 8),
            Text(
              "Slotly",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 26,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          // Spacer before buttons
          SizedBox(width: 8),

          // IMPROVED ADMIN BUTTON
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.15),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminLoginScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, Color(0xFFE56A5A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 10), // Reduced spacing

          // IMPROVED PATIENT BUTTON
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withOpacity(0.15),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientLoginScreen(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [secondaryColor, Color(0xFF5A9A94)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: secondaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Patient",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12), // Reduced from 16
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ENHANCED HERO SECTION WITH MORE CONTENT
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryLight.withOpacity(0.7),
                    secondaryLight.withOpacity(0.4),
                    backgroundColor.withOpacity(0.1)
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Decorative elements - floating icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _floatingIcon(Icons.access_time_filled, primaryColor),
                      _floatingIcon(Icons.calendar_today, secondaryColor),
                      _floatingIcon(Icons.health_and_safety, primaryColor),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Hero Image with decorative background and floating elements
                  Container(
                    width: 300,
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background decorative circles
                        Positioned(
                          right: 20,
                          top: 20,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 30,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondaryColor.withOpacity(0.1),
                            ),
                          ),
                        ),

                        // Main image container
                        Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [primaryColor, secondaryColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: 5,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Doctor illustration with improved styling
                              Container(
                                width: 240,
                                height: 240,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage("assets/doctor.png"),
                                    fit: BoxFit.cover,
                                    scale: 1.2,
                                  ),
                                ),
                              ),

                              // Decorative ring
                              Container(
                                width: 255,
                                height: 255,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Floating badge - "24/7 Available"
                        Positioned(
                          bottom: 40,
                          right: 20,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified, color: secondaryColor, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  "24/7 Available",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32),

                  // Main headline with improved typography
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Your Health,\n",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                          TextSpan(
                            text: "Our ",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                          TextSpan(
                            text: "Priority",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: primaryColor,
                              height: 1.1,
                              letterSpacing: -1,
                              shadows: [
                                Shadow(
                                  color: primaryColor.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Subtitle with statistics
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          "Join 50,000+ satisfied patients who trust Slotly with their health journey.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: subtleGray,
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Statistics row
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.8),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _statItem("50+", "Doctors", Icons.medical_services),
                              _divider(),
                              _statItem("24/7", "Support", Icons.support_agent),
                              _divider(),
                              _statItem("100%", "Secure", Icons.verified_user),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32),

                  // Single CTA Button
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: secondaryColor.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 3,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search, color: Colors.white, size: 22),
                            SizedBox(width: 12),
                            Text(
                              "Find a Doctor",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  // Trust indicators
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          "Trusted by leading hospitals",
                          style: TextStyle(
                            color: subtleGray,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _hospitalLogo("AMC"),
                            SizedBox(width: 20),
                            _hospitalLogo("CITY"),
                            SizedBox(width: 20),
                            _hospitalLogo("MED"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 48),

            // ENHANCED ABOUT SECTION
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  _enhancedSectionTitle("About Slotly", primaryColor),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Slotly is your bridge to better health. Patients can seamlessly browse doctors, check real-time availability, and manage appointments with a few taps. Administrators have dedicated tools to manage records, update schedules, and oversee the entire booking ecosystem.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.5,
                        color: textColor,
                        height: 1.7,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 48),

            // UPDATED: OUR TEAM SECTION
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _enhancedSectionTitle("Our Team", secondaryColor),
                  SizedBox(height: 16),
                  Text(
                    "Dedicated professionals managing your healthcare experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: subtleGray,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),

            // Team Cards with horizontal scroll
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  _enhancedTeamCard("Dr. Sarah", "Cardiologist", "assets/doctor.png", primaryColor),
                  SizedBox(width: 16),
                  _enhancedTeamCard("Dr. Ahmed", "Orthopedic", "assets/doctor.png", secondaryColor),
                  SizedBox(width: 16),
                  _enhancedTeamCard("Dr. Maria", "Dermatologist", "assets/doctor.png", primaryColor),
                  SizedBox(width: 16),
                  _enhancedTeamCard("Dr. James", "Pediatrician", "assets/doctor.png", secondaryColor),
                  SizedBox(width: 8),
                ],
              ),
            ),

            SizedBox(height: 40),

            // FAQ SECTION - IMPROVED SPACING
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _enhancedSectionTitle("Frequently Asked Questions", primaryColor),
                  SizedBox(height: 20),
                ],
              ),
            ),

            // FAQ Items with IMPROVED SPACING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _enhancedFaqTile(
                    "How do I book an appointment?",
                    "Simply register as a patient, choose a doctor, and select an available time slot. Confirmation will be sent immediately.",
                    secondaryColor,
                  ),
                  SizedBox(height: 8),
                  _enhancedFaqTile(
                    "Is booking free?",
                    "Yes, using the Slotly platform to book and manage appointments is completely free for patients.",
                    secondaryColor,
                  ),
                  SizedBox(height: 8),
                  _enhancedFaqTile(
                    "How do I register as an admin?",
                    "Admin accounts are exclusively provisioned by the system administrators for authorized personnel.",
                    secondaryColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // IMPROVED FOOTER - BETTER READABILITY
            Container(
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  // Logo in footer - improved contrast
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_services_outlined, color: Colors.white, size: 28),
                      SizedBox(width: 10),
                      Text(
                        "Slotly",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Contact info - improved contrast
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email_outlined, color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(
                              "support@slotly.com",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone_outlined, color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(
                              "+1 (555) 123-4567",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Social icons - improved contrast
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(Icons.facebook, Colors.white),
                      SizedBox(width: 16),
                      _socialIcon(Icons.wechat, Colors.white),
                      SizedBox(width: 16),
                      _socialIcon(Icons.camera_alt, Colors.white),
                      SizedBox(width: 16),
                      _socialIcon(Icons.link, Colors.white),
                    ],
                  ),

                  SizedBox(height: 24),

                  Divider(
                    color: Colors.white.withOpacity(0.4),
                    thickness: 1,
                  ),

                  SizedBox(height: 20),

                  // Copyright - improved contrast
                  Text(
                    "© 2025 Slotly. All rights reserved.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Your Health, Our Priority",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // UPDATED: Team card without "View Profile" button
  Widget _enhancedTeamCard(String name, String role, String imgPath, Color color) {
    return Container(
      width: 160,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Doctor image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.3), width: 3),
                ),
                child: ClipOval(
                  child: Image.asset(
                    imgPath,
                    width: 94,
                    height: 94,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Doctor name
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 8),

              // Role with colored background
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  role,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods for enhanced hero section

  Widget _floatingIcon(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  Widget _statItem(String value, String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: secondaryColor, size: 20),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: subtleGray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _hospitalLogo(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: secondaryColor,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _enhancedSectionTitle(String title, Color color) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: color,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _enhancedFaqTile(String title, String desc, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.question_mark,
            color: color,
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
            fontSize: 16,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              desc,
              style: TextStyle(
                color: subtleGray,
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Social icon with better contrast
  Widget _socialIcon(IconData icon, Color color) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 22, color: color),
        onPressed: () {},
        padding: EdgeInsets.zero,
      ),
    );
  }
}