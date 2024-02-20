import 'package:hive_flutter/hive_flutter.dart';

fn()
async{
  var box=await Hive.openBox('name');
  box.values;
}