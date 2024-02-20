import 'package:flutter/material.dart';
import '../datamodels/user.dart';
import '../themes/themes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_material.dart';
import 'reset_pin.dart';

class ChangePin1 extends StatefulWidget {
  final ValueNotifier user;
  const ChangePin1({super.key, required this.user});

  @override
  State<ChangePin1> createState() => _ChangePin1State();
}

class _ChangePin1State extends State<ChangePin1> {
  late User user;
  TextEditingController pinTec = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    user = widget.user.value;
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customMaterial(
              child: TextFormField(
                  controller: pinTec,
                  // autovalidateMode: AutovalidateMode.disabled,
                  validator: (value) {
                    if (value != user.pin.toString()) {
                      
                      return "wrong pin";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: dark),
                  decoration: inputDecoration('enter pin')),
            ),
            customButton(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPin(
                              user: user,
                            ),
                          ));
                  }
                },
                text: 'next',
                buttoncolor: materialColorDark,
                textcolor: light),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      )),
    );
  }
}
