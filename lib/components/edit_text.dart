import 'package:flutter/material.dart';

class TextFieldCl extends StatelessWidget {

  String labelText;
  String hintText;
  IconData icon;
  TextEditingController controller;
  TextFieldCl({super.key, required this.labelText, required this.hintText, required this.icon, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: const UnderlineInputBorder(),
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
