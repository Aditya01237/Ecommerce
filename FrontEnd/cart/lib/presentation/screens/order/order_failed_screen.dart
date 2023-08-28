import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderFailedScreen extends StatefulWidget {
  const OrderFailedScreen({super.key});

  static const routeName = "order_failed";

  @override
  State<OrderFailedScreen> createState() => _OrderFailedScreenState();
}

class _OrderFailedScreenState extends State<OrderFailedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(CupertinoIcons.xmark), Text("Order Failed")],
        ),
      ),
    );
  }
}
