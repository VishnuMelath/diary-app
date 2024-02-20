import 'package:flutter/material.dart';

import '../themes/themes.dart';

typedef FutureCallback = void Function(Future);

Widget customKeypad(Widget child) {
  return Material(
    borderRadius: BorderRadius.circular(15),
    elevation: 10,
    color: Colors.transparent,
    child: Container(
        width: 60,
        height: 60,
        decoration: boxDecoration1,
        child: Center(child: child)),
  );
}

Widget customKeypadMain(
    BuildContext context, Widget child, FutureCallback ontap) {
  return GestureDetector(
      onTap: () async {
        ontap;
      },
      child: customKeypad(child));
}

Widget customPinbar(ValueNotifier color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: color.value[0],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      ),
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: color.value[1],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      ),
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: color.value[2],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      ),
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: color.value[3],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      )
    ],
  );
}
