
import 'package:diaryapp/datamodels/globaldatas.dart';
import 'package:flutter/material.dart';

import '../datamodels/events.dart';

Widget customDateTimePicker(ValueNotifier<DateTime?> datenotifier,
    ValueNotifier<TimeOfDay?> timenotifier, BuildContext context,Events event) {
  Future<DateTime?> pickDate(BuildContext context, DateTime date1) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2100));
    return date ?? date1;
  }

  Future<TimeOfDay> pickTime() async {
    TimeOfDay? time = await showTimePicker(
        context: context, initialTime: timenotifier.value!);
    return time!;
  }

  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
    child: Column(mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () async {
                  datenotifier.value =
                      await pickDate(context, datenotifier.value!);
                      event.date=datenotifier.value!;
                },
                icon: const Icon(Icons.calendar_month_outlined)),
            ValueListenableBuilder<DateTime?>(
                valueListenable: datenotifier,
                builder: (context, date, _) {
                  return Text(
                      '${month[date!.month]} ${date.day} , ${date.year}');
                }),
          ],
        ),
      
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () async {
                  timenotifier.value = await pickTime();
                  // ignore: use_build_context_synchronously
                  event.time=timenotifier.value!.format(context);
                },
                icon: const Icon(Icons.timer_outlined)),
            ValueListenableBuilder<TimeOfDay?>(
                valueListenable: timenotifier,
                builder: (context, time, _) {
                  return Text(event.time);
                }),
          ],
        )
      ],
    ),
  );
}
