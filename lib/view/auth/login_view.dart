import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/login_view_model.dart';
import '../../Parent_pages/Parent_home_screen.dart';
import '../../child_pages/First_page.dart';
import '../../psychiatrist_pages/psychiatrist_Home_Page.dart';
import 'Forget_password_page.dart';
import 'Registration_Screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);
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

              // Role Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['Parent', 'Child', 'Psychiatrist'].map((role) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: role,
                        groupValue: loginVM.selectedRole,
                        onChanged: (value) {
                          loginVM.selectedRole = value;
                          loginVM.clearError();
                        },
                      ),
                      Text(role),
                      SizedBox(width: 20),
                    ],
                  );
                }).toList(),
              ),

              // Email & Password Fields
              SizedBox(height: 20),
              TextField(
                controller: loginVM.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.green[400]),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: loginVM.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.green[400]),
                ),
              ),

              // Forget Password
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ForgotPasswordScreen())),
                  child: Text("Forget Password", style: TextStyle(color: Colors.green[400])),
                ),
              ),

              // Login Button
              loginVM.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        var userModel = await loginVM.loginUser();
                        if (userModel != null) {
                          switch (userModel.role.toLowerCase()) {
                            case 'parent':
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ParentHomeScreen(
                                          userName: userModel.username,
                                          parentEmail: userModel.email,
                                          parentId: userModel.parentId ?? '',
                                        )),
                              );
                              break;
                            case 'child':
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChildHomePage(
                                          userName: userModel.username,
                                        )),
                              );
                              break;
                            case 'psychiatrist':
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PsychiatristHomePage(
                                          userName: userModel.username,
                                          doctorId: userModel.doctorId ?? '',
                                        )),
                              );
                              break;
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(screenWidth * 0.8, 50),
                        backgroundColor: Colors.green[400],
                      ),
                      child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),

              // Error Message
              if (loginVM.errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(loginVM.errorMessage, style: TextStyle(color: Colors.red)),
                ),

              // Registration Navigation
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterPage())),
                child: Text("Don't have an account? Sign up",
                    style: TextStyle(color: Colors.green[400])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
