import 'package:diaryapp/widgets/date_picker.dart';
import 'package:flutter/material.dart';

import '../datamodels/entry.dart';
import '../datamodels/globaldatas.dart';
import '../themes/themes.dart';
import 'addimage.dart';
import 'custom_button.dart';

Widget entry(Entry entry, BuildContext context, Widget button1, String title,
    GlobalKey<FormState> formkey) {
     ValueNotifier<DateTime?> datenotifier=ValueNotifier(entry.date);
  ValueNotifier<String> dropdownvalue = ValueNotifier('Category');
  ValueNotifier<List<String>> imagenotifier = ValueNotifier(entry.images);
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController entrycontroller = TextEditingController();
  titlecontroller.text = entry.title;
  entrycontroller.text = entry.entry;
  if (entry.category != '') {
    dropdownvalue.value = entry.category;
  }
  return ListView(
    key: UniqueKey(),
    shrinkWrap: true,
      children: [
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 10,
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
               customDatePicker(datenotifier, context, entry),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: titlecontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'title cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            entry.title = value;
                          },
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: canvasColor),
                          decoration: textfieldInputdecoration('title')),
                    ),
                    ValueListenableBuilder(
                        valueListenable: dropdownvalue,
                        builder: (context, ddvalue, child) {
                          return DropdownButton(
                              underline: const SizedBox(),
                              dropdownColor:
                                  const Color.fromRGBO(228, 234, 248, 1),
                              borderRadius: BorderRadius.circular(15),
                              hint: Text(
                                dropdownvalue.value,
                                style: const TextStyle(color: dark),
                              ),
                              items: categorylist.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: dark),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                dropdownvalue.value = value!;
                                entry.category = value;
                              });
                        })
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 211, 211, 211),
                ),
                TextFormField(
                    controller: entrycontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'entry cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      entry.entry = value;
                    },
                    maxLines: 20,
                    minLines: 10,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: canvasColor),
                    decoration: textfieldInputdecoration('entry')),
                SizedBox(
                    child: AddImage(entry: entry, imagenotifier: imagenotifier)
                    // addimage(entry,imagenotifier)

                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button1,
                    const SizedBox(
                      width: 20,
                    ),
                    title == 'edit'
                        ? customButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: 'cancel',
                            buttoncolor:
                                const MaterialStatePropertyAll(canvasColor),
                            textcolor: white)
                        : customButton(
                            onTap: () {
                              entrycontroller.text = '';
                              titlecontroller.text = '';
                              imagenotifier.value = [];
                            },
                            text: 'clear',
                            buttoncolor:
                                const MaterialStatePropertyAll(canvasColor),
                            textcolor: white)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
  ]);
}
