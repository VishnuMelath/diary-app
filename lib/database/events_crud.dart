import 'package:diaryapp/datamodels/events.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EventsCRUD {
  Future<int> insetEvents(Events events) async {
    Box<Events> box = await Hive.openBox('events');
    var val= await box.add(events);

    box.close();
    return val;
  }

  Future updateEvents(int index, Events event) async {
   Box<Events> box = await Hive.openBox('events');
    await box.put(index, event);
    box.close();
  }
Future deleteEvent(int index) async{
  Box<Events> box = await Hive.openBox('events');
  await box.deleteAt(index);
  box.close();
}
  Future<Map<dynamic, Events>> getAllEvents() async {
    Box<Events> box = await Hive.openBox('events');
    Map<dynamic, Events> events = box.toMap();
    box.close();
    return events;
  }
}
