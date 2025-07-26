import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream get authStateChanges => _firebaseAuth.authStateChanges();
  UserModel? _userFromFirebaseUser(User? user) {
    if (user == null) return null;

    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? user.email?.split('@')[0] ?? 'User',
    );
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = currentUser;
      return _userFromFirebaseUser(user);
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      final user = _userFromFirebaseUser(credential.user);
      if (user == null) {
        throw Exception('Failed to sign in');
      }
      
      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<UserModel> signUp(String email, String password, String displayName) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Update display name
      if (displayName.isNotEmpty) {
        await credential.user?.updateDisplayName(displayName);
        await credential.user?.reload();
      }

      final user = _userFromFirebaseUser(_firebaseAuth.currentUser);
      if (user == null) {
        throw Exception('Failed to create account');
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to send reset email: ${e.toString()}');
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
} 