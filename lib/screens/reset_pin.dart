import 'package:diaryapp/database/user_crud.dart';
import 'package:diaryapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../datamodels/user.dart';
import '../themes/themes.dart';
import '../widgets/custom_material.dart';

class ResetPin extends StatelessWidget {
  final User user;
  const ResetPin({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController pinTec = TextEditingController();

    // DateTime? dob;
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            stretch: true,
            expandedHeight: 150,
            floating: true,
            pinned: false,
            title: Text('reset pin', style: head2),
            flexibleSpace: Image.asset(
              'assets/images/mountain-4823516_1280.png',
              fit: BoxFit.fill,
            ),
          ),
          Form(
              key: formKey,
              child: SliverList(
                  delegate: SliverChildListDelegate([
                customMaterial(
                  child: TextFormField(
                      controller: pinTec,
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
                      validator: (value) {
                        if (value != pinTec.text) {
                          return "pin doesn't matches";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: canvasColor),
                      decoration: inputDecoration('re enter pin')),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            user.pin=int.parse(pinTec.text);
                         
                            updateUser(0, user).then((value){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('pin updated successfully')));
                              Navigator.pop(context);
                            });
                            
                          }
                        },
                        text: 'submit',
                        buttoncolor:
                            const MaterialStatePropertyAll(canvasColor),
                        textcolor: white),
                    const SizedBox(
                      width: 10,
                    ),
                    customButton(
                        onTap: () {Navigator.pop(context);},
                        text: 'cancel',
                        buttoncolor: materialColorLight,
                        textcolor: canvasColor)
                  ],
                )
              ])))
        ],
      ),
    ));
  }
}
