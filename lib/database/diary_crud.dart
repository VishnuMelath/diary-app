import 'package:hive_flutter/hive_flutter.dart';

import '../datamodels/entry.dart';

class EntryCRUD {
  Future insetEntry(Entry entry) async {
    Box<Entry> box = await Hive.openBox('entry');
    await box.add(entry);
    box.close();
  }

  Future updateEntry(int index, Entry entry) async {
    Box<Entry> box = await Hive.openBox('entry');
    await box.put(index, entry);
    box.close();
  }

  Future<Map<dynamic, Entry>> getAllEntry() async {
    Box<Entry> box = await Hive.openBox('entry');
    Map<dynamic, Entry> entry = box.toMap();
    return entry;
  }
  Future deleteEntry(int index) async{
    Box<Entry> box = await Hive.openBox('entry');
    await box.delete(index);
    box.close();
  }
}
