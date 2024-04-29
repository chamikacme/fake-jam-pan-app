import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        border: OutlineInputBorder(
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
