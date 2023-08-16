import 'package:flutter/cupertino.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const LoginScreen());

      case SignupScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SignupScreen());

      default:
        return null;
    }
  }
}
