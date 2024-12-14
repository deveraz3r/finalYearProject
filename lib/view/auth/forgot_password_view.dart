import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final ForgotPasswordViewmodel viewModel = Get.put(ForgotPasswordViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[400],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: viewModel.emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.green[400]),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              return ElevatedButton(
                onPressed: viewModel.isLoading.value
                    ? null
                    : () {
                  viewModel.sendPasswordResetEmail(viewModel.emailController.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: viewModel.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Send Reset Link',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                viewModel.message.value,
                style: TextStyle(
                  color: viewModel.message.value.contains('Error')
                      ? Colors.red
                      : Colors.green,
                  fontSize: 14,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
