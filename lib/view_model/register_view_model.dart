// view_model/register_view_model.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../Auth_Service/Auth_service_Screen.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  String _errorMessage = '';
  bool _isPasswordVisible = false;
  String _selectedRole = 'Parent'; // Default role

  String get errorMessage => _errorMessage;
  bool get isPasswordVisible => _isPasswordVisible;
  String get selectedRole => _selectedRole;

  void setPasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  void register(String username, String email, String password) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      notifyListeners();
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      _errorMessage = 'Only Gmail addresses are accepted.';
      notifyListeners();
      return;
    }

    if (!_isValidPassword(password)) {
      _errorMessage = 'Password must be at least 8 characters long and include at least one special character.';
      notifyListeners();
      return;
    }

    try {
      User? user = await _authService.registerUser(username, email, password);
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(User(
              username: username,
              email: email,
              role: _selectedRole,
            ).toMap());

        _errorMessage = 'Registration successful. Please verify your email.';
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
      notifyListeners();
    }
  }

  bool _isValidPassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$');
    return passwordRegExp.hasMatch(password);
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please log in.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'Registration failed: ${e.message}';
    }
  }
}
