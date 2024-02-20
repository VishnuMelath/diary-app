import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  String gender;

  @HiveField(2)
  DateTime dob;

  @HiveField(3)
  int pin;

  @HiveField(4)
  String question;

  @HiveField(5)
  String answer;
  @HiveField(6)
  String? image;

  User(
      {required this.name,
      required this.gender,
      required this.dob,
      required this.pin,
      required this.question,
      required this.answer,
      this.image});
}
