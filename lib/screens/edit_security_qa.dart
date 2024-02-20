import 'package:flutter/material.dart';

import '../database/user_crud.dart';
import '../datamodels/user.dart';
import '../themes/themes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class EditQA extends StatefulWidget {
  final ValueNotifier user;
  const EditQA({super.key, required this.user});

  @override
  State<EditQA> createState() => _EditQAState();
}

class _EditQAState extends State<EditQA> {
  TextStyle textStyle = const TextStyle(
    color: dark,
  );
  late User user;
    TextEditingController questointec = TextEditingController();
  TextEditingController answertec = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    user = widget.user.value;
    questointec.text=user.question;
    answertec.text=user.answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title:const Text('Edit security question answer')
        ),
      body: SafeArea(
          child: Form(
        key: formkey,
        child: ListView(
          shrinkWrap: true,
          children: [
            
            customTextfield(questointec, 'enter your security question',
                      'cannot be empty '),
                  customTextfield(answertec, 'enter your security answer',
                      'cannot be empty '),
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
          ],
        ),
      )),
    );
  }

  submit(BuildContext context, User user, ValueNotifier usernotifier) {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      user.question=questointec.text;
      user.answer=answertec.text;
      updateUser(0, user).then((value) {
        usernotifier.value = user;
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        usernotifier.notifyListeners();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Updated succesfully')));
      });
    }
  }
}
