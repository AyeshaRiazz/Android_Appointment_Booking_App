import 'package:flutter/material.dart';
import 'registerDoctor.dart';  // Import the registration screen
import 'viewDoctor.dart'; // Import the view doctors screen
import 'updateDoctor.dart'; // Import the update doctor screen

class AdminCrudScreen extends StatelessWidget {
  const AdminCrudScreen({super.key});

  // Theme colors to match your app
  final Color primaryColor = const Color(0xFFED7D6D); // Coral
  final Color secondaryColor = const Color(0xFF6AB1AB); // Teal
  final Color backgroundColor = const Color(0xFFF8F9FA);
  final Color textColor = const Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Section - Made more compact
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [secondaryColor, primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: secondaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white, size: 22),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        tooltip: 'Logout',
                      ),
                      Text(
                        "Admin Dashboard",
                        style: TextStyle(
                          fontSize: 20, // Reduced from 22
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(width: 48), // Spacer for balance
                    ],
                  ),
                  const SizedBox(height: 12), // Reduced from 16

                  // Welcome Card - More compact
                  Container(
                    padding: const EdgeInsets.all(12), // Reduced from 16
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14), // Reduced from 16
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10), // Reduced from 12
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1.5, // Reduced from 2
                            ),
                          ),
                          child: Icon(
                            Icons.admin_panel_settings,
                            color: Colors.white,
                            size: 24, // Reduced from 28
                          ),
                        ),
                        const SizedBox(width: 12), // Reduced from 16
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back, Admin",
                                style: TextStyle(
                                  fontSize: 16, // Reduced from 18
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2), // Reduced from 4
                              Text(
                                "Manage healthcare team",
                                style: TextStyle(
                                  fontSize: 12, // Reduced from 13
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), // Reduced
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16), // Reduced from 20
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.medical_services, color: Colors.white, size: 12), // Reduced
                              const SizedBox(width: 4), // Reduced from 6
                              Text(
                                "Doctors",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11, // Reduced from 12
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), // Reduced from 10
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title - More compact
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Doctor Management",
                            style: TextStyle(
                              fontSize: 22, // Reduced from 24
                              fontWeight: FontWeight.w800,
                              color: secondaryColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4), // Reduced from 6
                          Text(
                            "Manage doctor operations",
                            style: TextStyle(
                              fontSize: 13, // Reduced from 14
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // Reduced from 30

                    // CRUD Grid - Using Expanded for proper sizing
                    Expanded(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12, // Reduced from 16
                        mainAxisSpacing: 12, // Reduced from 16
                        childAspectRatio: 0.9, // Adjusted for better fit
                        padding: const EdgeInsets.only(bottom: 8),
                        children: [
                          _buildCrudOptionCard(
                            icon: Icons.person_add_alt_1,
                            title: "Register Doctor",
                            description: "Add new doctor",
                            color: secondaryColor,
                            gradientColors: [secondaryColor, const Color(0xFF5A9A94)],
                            onTap: () => _navigateToRegisterDoctor(context),
                          ),
                          _buildCrudOptionCard(
                            icon: Icons.people_alt,
                            title: "View Doctors",
                            description: "Browse all doctors",
                            color: primaryColor,
                            gradientColors: [primaryColor, const Color(0xFFE56A5A)],
                            onTap: () => _navigateToViewDoctors(context),
                          ),
                          _buildCrudOptionCard(
                            icon: Icons.edit_document,
                            title: "Update Doctor",
                            description: "Modify information",
                            color: Colors.blue.shade700,
                            gradientColors: [Colors.blue.shade700, Colors.blue.shade500],
                            onTap: () => _showDoctorSelectionDialog(context, true), // For update
                          ),
                          _buildCrudOptionCard(
                            icon: Icons.delete_forever,
                            title: "Delete Doctor",
                            description: "Remove doctor",
                            color: Colors.red.shade700,
                            gradientColors: [Colors.red.shade700, Colors.red.shade500],
                            onTap: () => _showDoctorSelectionDialog(context, false), // For delete
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Info Section
            Container(
              padding: const EdgeInsets.all(12), // Reduced from 16
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Added margin
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14), // Reduced from 16
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: secondaryColor,
                    size: 18, // Reduced from 20
                  ),
                  const SizedBox(width: 10), // Reduced from 12
                  Expanded(
                    child: Text(
                      "Admin actions are logged for security",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 11, // Reduced from 12
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget _buildCrudOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(16), // Reduced from 18
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                gradientColors[0].withOpacity(0.05),
                gradientColors[1].withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: color.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8, // Reduced from 10
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(12), // Reduced from 16
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Container - More compact
                Container(
                  width: 48, // Reduced from 56
                  height: 48, // Reduced from 56
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 6, // Reduced from 8
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 22, // Reduced from 24
                  ),
                ),

                const SizedBox(height: 10), // Reduced from 14

                // Title - More compact
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13, // Reduced from 14
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: 0.1,
                  ),
                  maxLines: 2,
                ),

                const SizedBox(height: 4), // Reduced from 6

                // Description - More compact
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10, // Reduced from 11
                    color: Colors.grey.shade600,
                    height: 1.2, // Reduced from 1.3
                  ),
                  maxLines: 2,
                ),

                const SizedBox(height: 8), // Reduced from 10

                // Action Indicator - More compact
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Reduced
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8), // Reduced from 10
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Open",
                        style: TextStyle(
                          fontSize: 9, // Reduced from 10
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2), // Reduced from 3
                      Icon(
                        Icons.arrow_forward,
                        size: 9, // Reduced from 10
                        color: color,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigate to Register Doctor screen
  void _navigateToRegisterDoctor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoctorRegistrationScreen(),
      ),
    );
  }

  // Navigate to View Doctors screen
  void _navigateToViewDoctors(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewDoctorsScreen(),
      ),
    );
  }

  void _showDoctorSelectionDialog(BuildContext context, bool isUpdate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isUpdate ? Icons.edit : Icons.delete,
              color: isUpdate ? Colors.blue : Colors.red,
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              isUpdate ? 'Update Doctor' : 'Delete Doctor',
              style: TextStyle(
                color: isUpdate ? Colors.blue.shade700 : Colors.red.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isUpdate
                  ? 'To update a doctor, please:'
                  : 'To delete a doctor, please:',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            _buildOptionTile(
              context,
              '1. Go to View Doctors',
              'Browse the list of all registered doctors',
              Icons.list_alt,
                  () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewDoctorsScreen(
                      onDoctorSelected: (doctorId, doctorName) {
                        if (isUpdate) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UpdateDoctorScreen(doctorId: doctorId),
                            ),
                          );
                        } else {
                          _showDeleteConfirmation(context, doctorId, doctorName);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildOptionTile(
              context,
              '2. Select a Doctor',
              isUpdate
                  ? 'Tap "Edit" on the doctor card'
                  : 'Tap "Delete" on the doctor card',
              isUpdate ? Icons.edit : Icons.delete_outline,
                  () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewDoctorsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ViewDoctorsScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isUpdate ? Colors.blue.shade700 : Colors.red.shade700,
            ),
            child: Text(
              'View Doctors',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: Colors.grey[700]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[500],
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String doctorId, String doctorName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange[700], size: 24),
            const SizedBox(width: 10),
            const Text('Delete Doctor'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete:',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade100),
              ),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.red.shade700, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Dr. $doctorName',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This action cannot be undone. All appointments and records associated with this doctor will be removed.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteDoctor(context, doctorId, doctorName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteDoctor(BuildContext context, String doctorId, String doctorName) {
    // This is a placeholder - you need to implement actual deletion logic
    // You'll need to import FirebaseFirestore and handle the deletion

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Delete functionality for $doctorName is ready to implement'),
        backgroundColor: secondaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}