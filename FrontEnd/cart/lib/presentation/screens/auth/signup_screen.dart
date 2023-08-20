import 'package:cart/presentation/screens/auth/login_screen.dart';
import 'package:cart/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = "signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Form(
        key: provider.formKey,
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
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (provider.error != "")
                          ? Text(
                              provider.error,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                PrimaryTextField(
                    controller: provider.emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email address is required!";
                      }
                      if (!EmailValidator.validate(value.trim())) {
                        return "Invalid email address";
                      }

                      return null;
                    },
                    labelText: "Email Address"),
                const SizedBox(height: 20),
                PrimaryTextField(
                  controller: provider.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required!";
                    }
                    return null;
                  },
                  labelText: "Password",
                ),

                const SizedBox(height: 20),
                PrimaryTextField(
                  controller: provider.cPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Confirm your password!";
                    }
                    if (value.trim() !=
                        provider.passwordController.text.trim()) {
                      return "Passwords do not match!";
                    }
                    return null;
                  },
                  labelText: "Confirm password",
                ),

                const SizedBox(height: 20),
                PrimaryButton(
                  onPressed: provider.createAccount,
                  text: (provider.isLoading) ? "..." : "Sign Up",
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ?",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    LinkButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      text: "Sign In",
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
