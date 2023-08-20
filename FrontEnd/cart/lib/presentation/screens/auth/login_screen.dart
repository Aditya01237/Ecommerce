import 'package:cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:cart/logic/cubits/user_cubit/user_state.dart';
import 'package:cart/presentation/screens/auth/signup_screen.dart';
import 'package:cart/presentation/screens/home/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import 'providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          // Navigator.pushNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
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
                    'Welcome back you\'ve been missed!',
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
                      labelText: "Password"),
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
                    onPressed: provider.logIn,
                    text: (provider.isLoading) ? "..." : "Sign In",
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
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        },
                        text: "Sign Up",
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
