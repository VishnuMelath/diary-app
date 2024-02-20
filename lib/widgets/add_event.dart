import 'package:diaryapp/widgets/custom_date_time_picker.dart';
import 'package:diaryapp/widgets/custom_material.dart';
import 'package:flutter/material.dart';
import '../datamodels/events.dart';
import '../themes/themes.dart';
import 'custom_button.dart';

Widget addEvent(BuildContext context, String title, int index, Widget button1,
    Events event,GlobalKey<FormState> formkey) {
  ValueNotifier<DateTime?> datenotifier = ValueNotifier(event.date);
  ValueNotifier<TimeOfDay?> timenotifier = ValueNotifier(TimeOfDay.now());
  TextEditingController titleController = TextEditingController(text: event.title);
  TextEditingController descController = TextEditingController(text: event.description);
  TextEditingController locationController = TextEditingController(text: event.location);
  return ListView(
    shrinkWrap: true,
    key: UniqueKey(),
    children: [
      Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            borderRadius: BorderRadius.circular(20),
           elevation: 10,
            color: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
              children: [
                customDateTimePicker(datenotifier, timenotifier, context, event),
                customMaterial(
                  child: TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'title cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        event.title = value;
                      },
                      style:  textstyletextbox,
                      decoration: inputDecoration('title')),
                ),
                customMaterial(
                  child: TextFormField(maxLines: 10,
                  minLines: 1,
                      controller: descController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'description cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        event.description = value;
                      },
                      style:textstyletextbox,
                      decoration: inputDecoration('description')),
                ),
                customMaterial(
                  child: TextFormField(
                      controller: locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'location cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        event.location = value;
                      },
                      style:textstyletextbox,
                      decoration: inputDecoration('location')),
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
                            buttoncolor: const MaterialStatePropertyAll(canvasColor),
                            textcolor: white)
                        : customButton(
                            onTap: () {
                              titleController.text = '';
                              descController.text = '';
                              datenotifier.value = DateTime.now();
                            },
                            text: 'clear',
                            buttoncolor: const MaterialStatePropertyAll(canvasColor),
                            textcolor: white)
                  ],
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
