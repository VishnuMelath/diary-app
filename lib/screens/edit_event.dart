import 'package:diaryapp/database/events_crud.dart';
import 'package:diaryapp/themes/themes.dart';
import 'package:diaryapp/widgets/add_event.dart';
import 'package:diaryapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../datamodels/events.dart';
import 'vertical/home_screen_android.dart';

class EditEvent extends StatelessWidget {
  final Events eventval;
  final int index;
  final int barindex;

  const EditEvent(
      {super.key,
      required this.eventval,
      required this.index,
      required this.barindex});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();
    Widget button1 = customButton(
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Update?'),
              actions: [
                customButton(
                    onTap: () async {
                      EventsCRUD().updateEvents(index, eventval).then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreenPhone(
                              index: barindex,
                              tabbarindex: 1,
                            ),
                          ),
                          (route) => false,
                        );
                      });
                    },
                    text: 'confirm',
                    buttoncolor: const MaterialStatePropertyAll(canvasColor),
                    textcolor: white),
                    customButton(
                    onTap: () async {
                    Navigator.of(context).pop();
                    },
                    text: 'cancel',
                    buttoncolor: const MaterialStatePropertyAll(light),
                    textcolor: white)
              ],
            ),
          );
        },
        text: 'save',
        buttoncolor: const MaterialStatePropertyAll(canvasColor),
        textcolor: white);

    return Scaffold(
        body: Container(
            color: canvasColor,
            child: SafeArea(
                child: Container(
                    color: white,
                    child: CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverAppBar(
                            centerTitle: true,
                            stretch: true,
                            expandedHeight: 150,
                            floating: true,
                            pinned: false,
                            title: Text('edit entry', style: head2),
                            flexibleSpace: Image.asset(
                              'assets/images/mountain-4823516_1280.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SliverFillRemaining(
                            child: addEvent(context, 'edit', index, button1,
                                eventval, formkey),
                          ),
                        ])))));
  }
}
