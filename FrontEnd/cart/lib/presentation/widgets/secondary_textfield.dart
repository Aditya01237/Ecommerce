import 'package:flutter/material.dart';

class SecondaryTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)? onChanged;

  const SecondaryTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}
