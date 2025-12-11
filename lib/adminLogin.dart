import 'package:flutter/material.dart';
// NOTE: Adjust the paths below based on your project structure
import 'package:appointment_booking_app/firebase_auth_service.dart';
import 'package:appointment_booking_app/adminSignup.dart';
import 'package:appointment_booking_app/admin_crud.dart';

class AdminLoginScreen extends StatefulWidget {
  final Color primaryColor = const Color(0xFFED7D6D); // Coral
  final Color secondaryColor = const Color(0xFF6AB1AB); // Teal

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  // FIX 1: Use 'late final' and initialize in initState()
  late final FirebaseAuthService _auth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuthService();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firebase call is safe here because _auth is initialized
        final user = await _auth.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );

        if (user != null) {
          // Success: Use mounted check before UI operations
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful! Redirecting to Dashboard.')),
            );
          }

          // ⭐ FIX 2: Use a definite delay (100ms) for stable navigation ⭐
          // This avoids the conflict between SnackBar and pushReplacement.
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AdminCrudScreen()),
              );
            }
          });
        }
      } catch (errorMessage) {
        // Error: Show the specific error message returned by the service
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage.toString())),
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
        title: Text("Admin Login", style: TextStyle(color: widget.primaryColor)),
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
                  "Admin Portal",
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
                  labelText: "Password",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (value) => (value == null || value.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Link to Sign Up
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminSignUpScreen()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: widget.secondaryColor, fontSize: 16),
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
        prefixIcon: Icon(icon, color: widget.secondaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.primaryColor, width: 2),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}