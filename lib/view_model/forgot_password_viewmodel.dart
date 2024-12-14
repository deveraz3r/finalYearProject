import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewmodel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var message = ''.obs;
  TextEditingController emailController = TextEditingController();

  // Function to send the password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      message.value = 'Please enter your email.';
      return;
    }

    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      message.value =
      'We have sent you an email to recover your password. Please check your inbox.';
    } catch (e) {
      message.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
