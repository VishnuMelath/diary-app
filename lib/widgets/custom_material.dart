import 'package:flutter/material.dart';

Widget customMaterial({required Widget child}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
    child: Center(
        child: Material(
            // borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            elevation: 1.0,
            shadowColor: const Color.fromARGB(0, 255, 255, 255),
            child: child)),
  );
}
