import 'package:diaryapp/functions/searchfn.dart';
import 'package:diaryapp/widgets/custom_sliverlist.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../database/diary_crud.dart';
import '../../datamodels/entry.dart';
import '../../themes/themes.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = [];
    ValueNotifier<bool> favnotifier = ValueNotifier(true);
    ValueNotifier datenotifier = ValueNotifier(DateTime.now());
    ValueNotifier<List> keysnotifier = ValueNotifier([]);
    Map<dynamic, Entry> entryMap = {};
    EntryCRUD().getAllEntry().then((value) {
      entryMap.addAll(value);
      entryMap.forEach((key, value) {
        dates.add(DateTime(value.date.year, value.date.month, value.date.day));
      });
      keysnotifier.value = searchEntrycalenderfn(
          selectedDate: DateTime.now(), entryMap: entryMap);
      datenotifier.value = DateTime.now();
    });
    search() {
      keysnotifier.value = [];
      keysnotifier.value.addAll(searchEntrycalenderfn(
          selectedDate: datenotifier.value, entryMap: entryMap));
      searchEntrycalenderfn(
          selectedDate: datenotifier.value, entryMap: entryMap);
    }

    return CustomScrollView(slivers: [
      SliverAppBar(
        centerTitle: true,
        stretch: true,
        expandedHeight: 150,
        floating: true,
        pinned: false,
        title: Text("Calender", style: head2),
        flexibleSpace: Image.asset(
          'assets/images/mountain-4823516_1280.png',
          fit: BoxFit.fill,
        ),
      ),
      ValueListenableBuilder(
          valueListenable: datenotifier,
          builder: (context, value, child) {
            return SliverToBoxAdapter(
              child: SfCalendar(
                initialSelectedDate: DateTime.now(),
                
                // allowedViews: [CalendarView.day,CalendarView.month,CalendarView.schedule],
                monthCellBuilder:
                    (BuildContext buildContext, MonthCellDetails details) {
                  bool isDateInList = dates.contains(details.date);
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      color: isDateInList ? canvasColor : white,
                      child: Center(
                        child: Text(
                          details.date.day.toString(),
                          style: TextStyle(
                              color: isDateInList ? white : canvasColor),
                        ),
                      ),
                    ),
                  );
                },
                maxDate: DateTime.now(),
                todayTextStyle: const TextStyle(color: Colors.white),
                showTodayButton: true,
                onTap: (calendarTapDetails) {
                  
                  datenotifier.value = calendarTapDetails.date;
                  search();
                },
                selectionDecoration:  BoxDecoration(
                  border: Border.all(color: Colors.green),
                    color: light.withOpacity(0.7)),
                headerStyle: const CalendarHeaderStyle(
                    backgroundColor: dark, textStyle: TextStyle(color: light)),
                backgroundColor: light,
                showDatePickerButton: true,
                view: CalendarView.month,
              ),
            );
          }),
      ValueListenableBuilder(
          valueListenable: keysnotifier,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return SliverList(
                  delegate: SliverChildListDelegate([
                ...customSliverList(
                    keynotfierdiary: keysnotifier,
                    favnotifier: favnotifier,
                    keys: keysnotifier.value,
                    entryMap: entryMap,
                    search: search,
                    context: context,
                    barindex: 3)
              ]));
            } else {
              return SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: empty,
              ));
            }
          })
    ]);
  }
}
