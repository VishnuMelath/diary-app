import 'package:hive_flutter/hive_flutter.dart';
part 'events.g.dart';

@HiveType(typeId: 3)
class Events
{
  @HiveField(0)
 String title;
   @HiveField(1)
 DateTime date;
   @HiveField(2)
  String description;
 @HiveField(3)
 String location;
 @HiveField(4)
 String time;


  Events( { required this.title, required this.date, required this.description,required this.location, required this.time});
}