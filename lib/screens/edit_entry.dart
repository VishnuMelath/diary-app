import 'package:diaryapp/database/diary_crud.dart';
import 'package:diaryapp/datamodels/entry.dart';
import 'package:diaryapp/themes/themes.dart';
import 'package:diaryapp/widgets/custom_button.dart';
import 'package:diaryapp/widgets/entry_widget.dart';
import 'package:flutter/material.dart';

import 'vertical/home_screen_android.dart';

class EditEntry extends StatelessWidget {
  final Entry entryval;
  final int index;
  final int barindex;

  const EditEntry(
      {super.key,
      required this.entryval,
      required this.index,
      required this.barindex});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();
    Widget button1 = customButton(
        onTap: () async {
          EntryCRUD().updateEntry(index, entryval).then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreenPhone(index: barindex,tabbarindex: 0,),
                  ),(route) => false,);
          });
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
                            child: entry(
                                entryval, context, button1, "edit", formkey),
                          ),
                        ])))));
  
  }
}
