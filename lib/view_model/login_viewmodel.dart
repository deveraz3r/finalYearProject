import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../Auth_Service/Auth_service_Screen.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedRole;
  bool isLoading = false;
  String errorMessage = '';

  Future<UserModel?> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (selectedRole == null) {
      errorMessage = 'Please select a role.';
      notifyListeners();
      return null;
    }

    try {
      isLoading = true;
      notifyListeners();

      User? user = await _authService.loginUser(email, password);
      if (user == null) {
        errorMessage = 'Login failed. Please check your credentials.';
        notifyListeners();
        return null;
      }

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        errorMessage = 'User not found in the database.';
        notifyListeners();
        return null;
      }

      UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>, user.uid);

      if (userModel.role.toLowerCase() != selectedRole!.toLowerCase()) {
        errorMessage = 'Role mismatch. Please select the correct role.';
        notifyListeners();
        return null;
      }

      isLoading = false;
      notifyListeners();

      return userModel;
    } catch (e) {
      errorMessage = 'An error occurred: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    errorMessage = '';
    notifyListeners();
  }
}
