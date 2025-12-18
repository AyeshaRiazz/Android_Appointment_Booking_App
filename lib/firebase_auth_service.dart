import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userModel.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Admin sign up with role
  Future<User?> adminSignUpWithEmailAndPassword(String email, String password) async {
    try {
      print("Admin signing up with email: $email");
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Create user document in Firestore with admin role
        await _createUserDocument(
          uid: credential.user!.uid,
          email: email,
          role: 'admin',
        );
      }

      print("Admin sign up successful! User ID: ${credential.user?.uid}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException during admin sign up: ${e.code} - ${e.message}");
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
      print("Exception during admin sign up: $e");
      throw 'An unexpected error occurred during sign up: $e';
    }
  }

  // Patient sign up with role
  Future<User?> patientSignUpWithEmailAndPassword(String email, String password) async {
    try {
      print("Patient signing up with email: $email");
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Create user document in Firestore with patient role
        await _createUserDocument(
          uid: credential.user!.uid,
          email: email,
          role: 'patient',
        );
      }

      print("Patient sign up successful! User ID: ${credential.user?.uid}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException during patient sign up: ${e.code} - ${e.message}");
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak (min 6 characters).';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already registered. Please log in.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Email/password accounts are not enabled.';
      } else {
        message = 'Registration failed: ${e.message ?? 'An unknown error occurred.'}';
      }
      throw message;
    } catch (e) {
      print("Exception during patient sign up: $e");
      throw 'An unexpected error occurred during registration: $e';
    }
  }

  // Admin login with role check
  Future<User?> adminSignInWithEmailAndPassword(String email, String password) async {
    try {
      print("Admin signing in with email: $email");
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Check if user has admin role
        final userDoc = await _firestore.collection('users').doc(credential.user!.uid).get();

        if (!userDoc.exists || userDoc.data()?['role'] != 'admin') {
          await _auth.signOut(); // Sign out if not admin
          throw 'This email is not registered as an admin.';
        }
      }

      print("Admin sign in successful! User ID: ${credential.user?.uid}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException during admin sign in: ${e.code} - ${e.message}");
      String message;
      if (e.code == 'user-not-found') {
        message = 'No admin found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid email or password.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'user-disabled') {
        message = 'This admin has been disabled.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Please try again later.';
      } else {
        message = 'Login failed: ${e.message ?? 'An unknown error occurred.'}';
      }
      throw message;
    } catch (e) {
      print("Exception during admin sign in: $e");
      throw e.toString();
    }
  }

  // Patient login with role check
  Future<User?> patientSignInWithEmailAndPassword(String email, String password) async {
    try {
      print("Patient signing in with email: $email");
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Check if user has patient role
        final userDoc = await _firestore.collection('users').doc(credential.user!.uid).get();

        if (!userDoc.exists || userDoc.data()?['role'] != 'patient') {
          await _auth.signOut(); // Sign out if not patient
          throw 'This email is not registered as a patient.';
        }
      }

      print("Patient sign in successful! User ID: ${credential.user?.uid}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException during patient sign in: ${e.code} - ${e.message}");
      String message;
      if (e.code == 'user-not-found') {
        message = 'No patient found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid email or password.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'user-disabled') {
        message = 'This patient has been disabled.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Please try again later.';
      } else {
        message = 'Login failed: ${e.message ?? 'An unknown error occurred.'}';
      }
      throw message;
    } catch (e) {
      print("Exception during patient sign in: $e");
      throw e.toString();
    }
  }

  // Helper method to create user document
  Future<void> _createUserDocument({
    required String uid,
    required String email,
    required String role,
  }) async {
    try {
      final userModel = UserModel(
        uid: uid,
        email: email,
        role: role,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(uid).set(userModel.toMap());
      print("User document created for $email with role: $role");
    } catch (e) {
      print("Error creating user document: $e");
      throw 'Failed to create user profile';
    }
  }

  // Get current user role
  Future<String?> getUserRole(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data()?['role'];
      }
      return null;
    } catch (e) {
      print("Error getting user role: $e");
      return null;
    }
  }

  // Get current user data
  Future<UserModel?> getCurrentUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return UserModel.fromMap(userDoc.data()!);
        }
      }
      return null;
    } catch (e) {
      print("Error getting user data: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}