import 'package:flutter/material.dart';
// NOTE: Adjust the path below based on your project structure
import 'package:appointment_booking_app/firebase_auth_service.dart';

class AdminSignUpScreen extends StatefulWidget {
  final Color primaryColor = const Color(0xFFED7D6D); // Coral
  final Color secondaryColor = const Color(0xFF6AB1AB); // Teal

  @override
  _AdminSignUpScreenState createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {
  // FIX 1: Use 'late final' and initialize in initState()
  late final FirebaseAuthService _auth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuthService();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match.')),
          );
        }
        return;
      }

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        print("Attempting sign up...");
        final user = await _auth.signUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );

        Navigator.of(context).pop(); // Remove loading dialog

        if (user != null) {
          print("Sign up successful, user created!");
          // Success: Show message safely
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign Up Successful! Please log in.')),
            );
          }

          // Navigate back after short delay
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        }
      } catch (errorMessage) {
        Navigator.of(context).pop(); // Remove loading dialog
        print("Sign up error caught: $errorMessage");

        // Error: Show the specific error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage.toString()),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build method remains as provided
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Sign Up", style: TextStyle(color: widget.primaryColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: widget.primaryColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Create Admin Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: widget.secondaryColor,
                  ),
                ),
                const SizedBox(height: 40),

                // Email Input
                _buildTextField(
                  controller: _emailController,
                  labelText: "Email",
                  icon: Icons.email,
                  validator: (value) => (value == null || value.isEmpty || !value.contains('@')) ? 'Please enter a valid email' : null,
                ),
                const SizedBox(height: 20),

                // Password Input
                _buildTextField(
                  controller: _passwordController,
                  labelText: "Password (min 6 chars)",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (value) => (value == null || value.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 20),

                // Confirm Password Input
                _buildTextField(
                  controller: _confirmPasswordController,
                  labelText: "Confirm Password",
                  icon: Icons.lock_open,
                  isPassword: true,
                  validator: (value) => (value == null || value.isEmpty || value != _passwordController.text) ? 'Passwords do not match' : null,
                ),
                const SizedBox(height: 30),

                // Sign Up Button
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.secondaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: widget.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.secondaryColor, width: 2),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}