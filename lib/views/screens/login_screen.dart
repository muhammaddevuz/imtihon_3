import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3/services/auth_http_services.dart';
import 'package:imtihon3/utils/admin.dart';
import 'package:imtihon3/views/screens/admin_panel/admin_panel.dart';
import 'package:imtihon3/views/screens/home_screen.dart';
import 'package:imtihon3/views/screens/register_screen.dart';
import 'package:imtihon3/views/screens/reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;
  LoginScreen({super.key, required this.themChanged});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;
  Color buttonColor = const Color.fromARGB(255, 230, 228, 228);

  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonColor);
    _passwordController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateButtonColor);
    _passwordController.removeListener(_updateButtonColor);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      final isValidEmail = _emailController.text.isNotEmpty &&
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              .hasMatch(_emailController.text);
      final isValidPassword = _passwordController.text.length >= 6;

      if (isValidEmail && isValidPassword) {
        buttonColor = Colors.blue;
      } else {
        buttonColor = Color.fromARGB(255, 190, 189, 189);
      }
    });
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      if (email == Admin.admin['login'] && password == Admin.admin['parol']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return AdminPanel();
            },
          ),
        );
      }

      try {
        await _authHttpServices.login(email!, password!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return HomeScreen(
                themChanged: widget.themChanged,
              );
            },
          ),
        );
      } on Exception catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email already exists";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/hotels_logo.png",
                width: 150.w,
              ),
              SizedBox(height: 30.h),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your email address";
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  email = newValue;
                },
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Password must contain at least 6 characters";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  password = newValue;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Password reset?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : IconButton(
                      onPressed: submit,
                      icon: Container(
                        alignment: Alignment.center,
                        height: 40.h,
                        width: 330.w,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Don’t have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(148, 147, 149, 1),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return RegisterScreen(
                                themChanged: widget.themChanged,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
