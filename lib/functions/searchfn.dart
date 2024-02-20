import 'package:diaryapp/datamodels/entry.dart';

List searchEntryfn(
    {required String dropdownvalue,
    required String search,
    required Map entryMap}) {
  RegExp textReg = RegExp(r'' + search, caseSensitive: false);

  RegExp filter = dropdownvalue == 'All' || dropdownvalue == 'Category'
      ? RegExp(r'', caseSensitive: false)
      : RegExp(r'' + dropdownvalue, caseSensitive: false);

  List keys = [];
  entryMap.forEach((key, value) {
    if ((textReg.hasMatch(value.title) || textReg.hasMatch(value.entry)) &&
        filter.hasMatch(value.category)) {
      keys.add(key);
    }
  });

  return keys;
}
List searchEventsfn(
    {required String search,
    required Map eventsMap}) {
  RegExp textReg = RegExp(r'' + search, caseSensitive: false);

  // RegExp filter = dropdownvalue == 'All' || dropdownvalue == 'Category'
  //     ? RegExp(r'', caseSensitive: false)
  //     : RegExp(r'' + dropdownvalue, caseSensitive: false);

  List keys = [];
  eventsMap.forEach((key, value) {
    if ((textReg.hasMatch(value.title) || textReg.hasMatch(value.description)) ) {
      keys.add(key);
    }
  });

  return keys;
}

List searchEntryfavfn(
    {required String dropdownvalue,
    required String search,
    required Map<dynamic, Entry> entryMap}) {
  RegExp textReg = RegExp(r'' + search, caseSensitive: false);

  RegExp filter = dropdownvalue == 'All' || dropdownvalue == 'Category'
      ? RegExp(r'', caseSensitive: false)
      : RegExp(r'' + dropdownvalue, caseSensitive: false);

  List keys = [];
  entryMap.forEach((key, value) {
    if ((textReg.hasMatch(value.title) || textReg.hasMatch(value.entry)) &&
        filter.hasMatch(value.category) &&
        value.fav == true) {
      keys.add(key);
    }
  });

  return keys;
}

List searchEntrycalenderfn(
    {required DateTime selectedDate, required Map<dynamic, Entry> entryMap}) {
  List keys = [];
  entryMap.forEach((key, value) {
    if (selectedDate.year == value.date.year &&
        selectedDate.day == value.date.day &&
        selectedDate.month == value.date.month) {
      keys.add(key);
    }
  });
  return keys;
}
