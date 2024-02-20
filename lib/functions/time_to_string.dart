import 'package:flutter/material.dart';

TimeOfDay stringToTimeOfDay(String timeString) {
  List<String> components = timeString.split(':');
  int hour = int.parse(components[0]);
  int minute = int.parse(components[1]);
  return TimeOfDay(hour: hour, minute: minute);
}