import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      print("Signing up with email: $email");
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Sign up successful! User ID: ${credential.user?.uid}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException during sign up: ${e.code} - ${e.message}");
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak (min 6 characters).';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Email/password accounts are not enabled.';
      } else {
        message = 'Sign up failed: ${e.message ?? 'An unknown error occurred.'}';
      }
      throw message;
    } catch (e) {
      // Add detailed logging for non-Firebase exceptions
      print("Non-Firebase exception during sign up: $e");
      print("Exception type: ${e.runtimeType}");
      if (e is FirebaseException) {
        print("FirebaseException: ${e.code} - ${e.message}");
      }
      throw 'An unexpected error occurred during sign up: $e';
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      print("Signing in with email: $email");
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Sign in successful! User ID: ${credential.user?.uid}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException during sign in: ${e.code} - ${e.message}");
      String message;
      if (e.code == 'user-not-found') {
        message = 'No admin found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid email or password.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'user-disabled') {
        message = 'This user has been disabled.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Please try again later.';
      } else {
        message = 'Login failed: ${e.message ?? 'An unknown error occurred.'}';
      }
      throw message;
    } catch (e) {
      print("Non-Firebase exception during sign in: $e");
      print("Exception type: ${e.runtimeType}");
      throw 'An unexpected error occurred during login: $e';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}