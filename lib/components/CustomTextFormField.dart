import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isNumber;

  const CustomTextFormField(
      {Key? key, required this.controller, this.isNumber = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
            ).colorScheme.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
            ).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
