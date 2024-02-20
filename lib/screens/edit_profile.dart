// ignore_for_file: invalid_use_of_protected_member

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

class EditProfile extends StatefulWidget {
  final ValueNotifier user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextStyle textStyle = const TextStyle(
    color: dark,
  );
  late DateTime dob;
  late User user;
  GlobalKey<FormState> formkey = GlobalKey();
  ValueNotifier<String> image = ValueNotifier('');
  ValueNotifier<String> dropdownvalue = ValueNotifier('Gender');
  TextEditingController nametec = TextEditingController();
  final List<String> genderlist = <String>['Male', 'Female', 'Others'];
  @override
  void initState() {
    super.initState();

    user = widget.user.value;
    dob = user.dob;
    image.value = user.image ?? '';
    dropdownvalue.value = user.gender;
    nametec.text = user.name;
  }

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
                              hint: Text(val),
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
                          initialDate: dob,
                          dateFormatType: DateFormatType.MMDDYYYY,
                          onDateSaved: (value) {
                            dob = value;
                          },
                          onDateSubmitted: (value) {
                            dob = value;
                          },
                          inputDecoration: inputDecoration('DD/MM/YYYY'),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customButton(
                          onTap: () {
                            submit(context, user, widget.user);
                          },
                          text: 'submit',
                          buttoncolor: materialColorDark,
                          textcolor: light),
                      const SizedBox(
                        width: 10,
                      ),
                      customButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: 'cancel',
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

  submit(BuildContext context, User user, ValueNotifier usernotifier) {
    user.name = nametec.text;
    user.image = image.value;
    user.dob = dob;
    user.gender = dropdownvalue.value;
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      updateUser(0, user).then((value) {
        usernotifier.value = user;
        // ignore: invalid_use_of_visible_for_testing_member
        usernotifier.notifyListeners();
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Updated succesfully')));
      });
    }
  }
}
