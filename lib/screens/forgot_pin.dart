
import 'package:diaryapp/screens/reset_pin.dart';
import 'package:diaryapp/widgets/custom_button.dart';
import 'package:diaryapp/widgets/custom_textfield.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import '../database/user_crud.dart';
import '../themes/themes.dart';
import '../widgets/custom_material.dart';

class ForgotPin extends StatelessWidget {
  const ForgotPin({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController nameController = TextEditingController();
    TextEditingController securityAnswerController = TextEditingController();

    DateTime? dob;
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
                customTextfield(nameController, 'name', 'name cannot be empty'),
                customMaterial(
                    child: DOBInputField(
                        fieldHintText: 'date of birth',
                        onDateSaved: (value) {
                          dob = value;
                        },
                        onDateSubmitted: (value) {
                          dob = value;
                        },
                        inputDecoration:
                            inputDecoration('DD/MM/YYYY date of birth'),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now())),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Text('security question ?'),
                ),
                customTextfield(securityAnswerController, 'security answer',
                    'answer cannot be empty'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                        onTap: () async{
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                             getUserData().then((value) {
                             
                              if(nameController.text==value.name
                              &&dob!.day==value.dob.day
                              &&dob!.month==value.dob.month
                              &&dob!.year==value.dob.year
                              &&securityAnswerController.text==value.answer){
                                 Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  ResetPin(user: value,),
                                ));
                              }
                              else{
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red,content: Text('invalid details'),duration: Duration(seconds: 2),));
                              }
                            
                             }
                             );
                            
                          }
                        },
                        text: 'next',
                        buttoncolor:
                            const MaterialStatePropertyAll(canvasColor),
                        textcolor: white),
                    const SizedBox(
                      width: 10,
                    ),
                    customButton(
                        onTap: () {

                        },
                        text: 'clear',
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
