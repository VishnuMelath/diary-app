import 'package:flutter/material.dart';

Widget customButton(
    {required VoidCallback onTap,
    required String text,
    required MaterialStateProperty<Color> buttoncolor,
    required Color textcolor}) {
  return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          backgroundColor: buttoncolor,
          elevation: const MaterialStatePropertyAll(10)),
      child: Text(
        text,
        style: TextStyle(color: textcolor),
      ));
}
