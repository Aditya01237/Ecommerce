import 'package:cart/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'core/routes.dart';
import 'core/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.defaultTheme,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: LoginScreen.routeName,
    );
  }
}
