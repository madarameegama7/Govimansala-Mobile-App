import 'package:flutter/material.dart';
import 'package:govimansala/pages/home_page.dart';
import 'package:govimansala/services/auth_service.dart';
// import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:govimansala/pages/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png',
                  height: 80,
                ),
                const SizedBox(height: 8),

                // Govi Mansala Title
                Text.rich(
                  TextSpan(
                    text: 'Govi ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Mansala',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Log in Text
                Text(
                  'Log in',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700]),
                ),
                const SizedBox(height: 24),

                // Email Field
                TextField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    labelStyle: TextStyle(color: Colors.green),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: TextStyle(color: Colors.black), // 👈 text color
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Colors.green), // 👈 label color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // 👈 match email field
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black, // 👈 make eye icon green
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 8),


                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      print('Calling AuthService.login...');

                      bool success = await AuthService.login(email, password);

                      if (success) {
                        print('Login successful, navigating to HomePage...');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        print('Login failed, showing snackbar...');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid email or password')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Log in',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ),
                ),
                const SizedBox(height: 24),


                // Signup
                     Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.blue.shade600),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: Colors.grey[200],
        radius: 24,
        child: Image.asset(assetPath, height: 24),
      ),
    );
  }
}
