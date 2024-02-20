import 'package:hive/hive.dart';

part 'entry.g.dart';

@HiveType(typeId: 2)
class Entry{
  @HiveField(0)
  String title;
  @HiveField(1)
  String entry;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  List<String> images;
  @HiveField(4)
  bool fav;
  @HiveField(5)
  String category;

  Entry(
      {required this.title,
      required this.entry,
      required this.date,
      required this.images,
      required this.fav,
      required this.category});
}
