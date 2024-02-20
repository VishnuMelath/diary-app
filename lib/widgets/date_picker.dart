
import 'package:diaryapp/datamodels/entry.dart';
import 'package:diaryapp/datamodels/globaldatas.dart';
import 'package:flutter/material.dart';

Widget customDatePicker(ValueNotifier<DateTime?> datenotifier,
     BuildContext context,Entry entry) {
  Future<DateTime?> pickDate(BuildContext context, DateTime date1) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate:DateTime(1900) , lastDate:DateTime.now() );
    return date ?? date1;
  }



  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(
          onPressed: () async {
            datenotifier.value =
                await pickDate(context, datenotifier.value!);
                entry.date=datenotifier.value!;
          },
          icon: const Icon(Icons.calendar_month_outlined)),
      ValueListenableBuilder<DateTime?>(
          valueListenable: datenotifier,
          builder: (context, date, _) {
            return Text(
                '${month[date!.month]} ${date.day} , ${date.year}');
          }),
    
     
    ],
  );
}
