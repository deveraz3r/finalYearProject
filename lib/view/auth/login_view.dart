import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/login_viewmodel.dart';
import 'registration_screen.dart';
import 'forgot_password_view.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel _viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Log in to continue to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 40),
              Obx(() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['Parent', 'Child', 'Psychiatrist']
                        .map((role) => Row(
                      children: [
                        Radio<String>(
                          value: role,
                          groupValue: _viewModel.selectedRole.value,
                          onChanged: (value) =>
                          _viewModel.selectedRole.value = value!,
                        ),
                        Text(role),
                      ],
                    ))
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => _viewModel.email.value = value,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.green[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => _viewModel.password.value = value,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.green[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.to(() => ForgotPasswordScreen()),
                      child: Text(
                        "Forget Password",
                        style: TextStyle(color: Colors.green[400], fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(() => _viewModel.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _viewModel.login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.8, 50),
                      backgroundColor: Colors.green[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
                  if (_viewModel.errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Obx(() => Text(
                        _viewModel.errorMessage.value,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )),
                    ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Get.to(() => RegisterPage()),
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(color: Colors.green[400], fontSize: 16),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
