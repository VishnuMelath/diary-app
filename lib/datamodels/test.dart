import 'package:hive_flutter/hive_flutter.dart';
part 'test.g.dart';
@HiveType(typeId: 5)
class Test{
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? age;
}