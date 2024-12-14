// view/register_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/register_view_model.dart';
import 'Login_Screen.dart';

class RegisterPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: Text('Register', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[400],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Enter your personal details to get started',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: 'Parent',
                              groupValue: viewModel.selectedRole,
                              onChanged: (value) {
                                viewModel.setSelectedRole(value!);
                              },
                            ),
                            Text('Parent'),
                            SizedBox(width: 20),
                            Radio<String>(
                              value: 'Psychiatrist',
                              groupValue: viewModel.selectedRole,
                              onChanged: (value) {
                                viewModel.setSelectedRole(value!);
                              },
                            ),
                            Text('Psychiatrist'),
                          ],
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person, color: Colors.green[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Colors.green[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: !viewModel.isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock, color: Colors.green[400]),
                            suffixIcon: IconButton(
                              icon: Icon(
                                viewModel.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.green[400],
                              ),
                              onPressed: viewModel.setPasswordVisibility,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.register(
                        _nameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.8, 50),
                      backgroundColor: Colors.green[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  if (viewModel.errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        viewModel.errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Already have an account? Log in",
                      style: TextStyle(color: Colors.green[400], fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
