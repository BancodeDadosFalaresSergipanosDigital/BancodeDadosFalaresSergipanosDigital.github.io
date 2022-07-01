import 'package:flutter/material.dart';

Widget InputField({required TextEditingController controller, required Size size, required IconData icon, bool obscureText = false}) {
  return Container(
    width: size.width * 0.3,
    height: 60,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black, width: 2)),
    child: TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(icon),
      ),
      maxLines: 1,textAlignVertical: TextAlignVertical.bottom,
    ),
  );
}