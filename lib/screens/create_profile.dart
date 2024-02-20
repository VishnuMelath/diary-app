import 'dart:io';

import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';

import '../database/user_crud.dart';
import '../datamodels/user.dart';
import '../functions/imagepickfn.dart';
import '../themes/themes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_material.dart';
import '../widgets/custom_textfield.dart';
import 'lock_screen.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  late DateTime dob;
  GlobalKey<FormState> formkey = GlobalKey();
  ValueNotifier<String> image = ValueNotifier('');
  ValueNotifier<String> dropdownvalue = ValueNotifier('Gender');
  TextEditingController nametec = TextEditingController();
  TextEditingController pintec = TextEditingController();
  TextEditingController repintec = TextEditingController();
  TextEditingController questointec = TextEditingController();
  TextEditingController answertec = TextEditingController();
  TextStyle textStyle = const TextStyle(
    color: dark,
  );
  final List<String> genderlist = <String>['Male', 'Female', 'Others'];
  RegExp pin = RegExp(r'^[0-9]{4}$');

  // builder..............................................................................................
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                      valueListenable: image,
                      builder: (context, images, child) {
                        return GestureDetector(
                          onTap: () {
                            pickImage().then((value) {
                              image.value = value;
                            });
                          },
                          child: images == ''
                              ? Image.asset(
                                  'assets/images/add-friend.png',
                                  width: 100,
                                )
                              : Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(File(images)),
                                      child: const Align(
                                          alignment: Alignment.bottomRight,
                                          child: Icon(
                                            Icons.add_circle,
                                            color: Colors.green,
                                          )),
                                    ),
                                  ],
                                ),
                        );
                      }),
                  customTextfield(nametec, 'name', 'name cannot be empty'),
                  customMaterial(
                    child: ValueListenableBuilder(
                        valueListenable: dropdownvalue,
                        builder: (context, val, child) {
                          return DropdownButtonFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (dropdownvalue.value == 'Gender') {
                                  return 'please select an option';
                                }
                                return null;
                              },
                              dropdownColor: dropdowncolor,
                              borderRadius: BorderRadius.circular(15),
                              decoration: inputDecoration('gender'),
                              items: genderlist.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: textStyle,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                dropdownvalue.value = value!;
                              });
                        }),
                  ),
                  customMaterial(
                      child: DOBInputField(
                          onDateSaved: (value) {
                            dob = value;
                          },
                          onDateSubmitted: (value) {
                            dob = value;
                          },
                          inputDecoration: inputDecoration('DD/MM/YYYY'),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())),
                  customMaterial(
                    child: TextFormField(
                        controller: pintec,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.length != 4) {
                            return "enter a valid 4 digit pin";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: dark),
                        decoration: inputDecoration('enter pin')),
                  ),
                  customMaterial(
                    child: TextFormField(
                        obscureText: true,
                        controller: repintec,
                        validator: (value) {
                          if (value != pintec.text) {
                            return "pin doesn't matches";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: canvasColor),
                        decoration: inputDecoration('re enter pin')),
                  ),
                  customTextfield(questointec, 'enter your security question',
                      'cannot be empty '),
                  customTextfield(answertec, 'enter your security answer',
                      'cannot be empty '),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customButton(
                          onTap: submit,
                          text: 'submit',
                          buttoncolor: materialColorDark,
                          textcolor: light),
                      const SizedBox(
                        width: 10,
                      ),
                      customButton(
                          onTap: clear,
                          text: 'clear',
                          buttoncolor: materialColorLight,
                          textcolor: canvasColor)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  submit() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      insertUser(User(
              name: nametec.text,
              gender: dropdownvalue.value,
              dob: dob,
              pin: int.parse(pintec.text),
              question: questointec.text,
              answer: answertec.text,
              image: image.value))
          .then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LockScreen(),
            ));
      });
    }
  }

  clear() {
    image.value = '';
    setState(() {
      nametec.text = '';
      pintec.text = '';
      questointec.text = '';
      answertec.text = '';
      repintec.text = '';
      image.value = '';
    });
  }
}
