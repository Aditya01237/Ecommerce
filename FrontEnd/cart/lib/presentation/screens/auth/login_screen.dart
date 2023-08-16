import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // logo
              SizedBox(
                width: 170,
                height: 170,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 50),
              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),
              PrimaryTextField(
                controller: emailController,
                labelText: "Email Address",
              ),
              const SizedBox(height: 20),
              PrimaryTextField(
                controller: passwordController,
                labelText: "Password",
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LinkButton(
                      onPressed: () {},
                      text: "Forget Password ?",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                onPressed: () {},
                text: "Sign In",
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ?",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  LinkButton(
                    onPressed: () {},
                    text: "Sign Up",
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
