import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/auth_view_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.green[400]),
              ),
            ),
            SizedBox(height: 20),
            authVM.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      authVM.sendPasswordResetEmail(_emailController.text.trim());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Send Reset Link',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
            SizedBox(height: 10),
            if (authVM.message.isNotEmpty)
              Text(
                authVM.message,
                style: TextStyle(
                  color: authVM.message.contains('Error') ? Colors.red : Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OTPVerificationScreen extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (authVM.validateOTP(_otpController.text.trim())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('OTP Verified Successfully!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid OTP')),
                  );
                }
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
