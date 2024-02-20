import 'package:flutter/material.dart';

import '../themes/themes.dart';
import 'custom_material.dart';

Widget customTextfield(
    TextEditingController controller, String hintText, String errortext) {
  return customMaterial(
    child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == '') {
            return errortext;
          }
          return null;
        },
        style: const TextStyle(color: canvasColor),
        decoration: inputDecoration(hintText)),
  );
}
