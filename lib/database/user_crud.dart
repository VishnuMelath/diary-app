import 'package:hive/hive.dart';

import '../datamodels/user.dart';

Future<int> insertUser(User user) async {
  Box<User> userBox = await Hive.openBox('userdata');
  var result = userBox.add(user);
  await userBox.close();
  return result;
}

Future updateUser(int id, User user) async {
  Box<User> userBox = await Hive.openBox('userdata');
  userBox.put(id, user);
  await userBox.close();
}

Future<int> checkLogged() async {
  Box<User> userBox = await Hive.openBox('userdata');
  int len = userBox.length;
  await userBox.close();
  return len;
}

Future<int> getPin() async {
  Box<User> userBox = await Hive.openBox('userdata');
  User? user = userBox.get(0);
  userBox.close();
  return user!.pin;
}
Future<User> getUserData() async{
    Box<User> userBox = await Hive.openBox('userdata');
  User user = userBox.get(0)!;
  userBox.close();
  return user;
}
