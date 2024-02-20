import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:diaryapp/database/events_crud.dart';
import 'package:diaryapp/screens/edit_event.dart';
import 'package:flutter/material.dart';
import '../datamodels/events.dart';
import '../datamodels/globaldatas.dart';
import '../themes/themes.dart';
import 'custom_button.dart';

Widget eventList(
    {required Map<dynamic, Events> eventMap,
    required VoidCallback search,
    required BuildContext context,
    required int barindex,
    required ValueNotifier keynotfierevents,
    required List keysevents}) {
  return ListView.builder(
    itemCount: keysevents.length,
    itemBuilder: (context, index) {
      ValueNotifier<bool> visible = ValueNotifier(false);
      DateTime date = eventMap[keysevents[index]]!.date;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  visible.value = !visible.value;
                },
                title: Text(
                  eventMap[keysevents[index]]!.title,
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text(eventMap[keysevents[index]]!.location),
                trailing: PopupMenuButton(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEvent(
                              eventval: eventMap[keysevents[index]]!,
                              index: keysevents[index],
                              barindex: barindex,
                            ),
                          ));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete'),
                          content: Text('are you sure?'),
                          actions: [
                            customButton(
                                onTap: () async {
                                  await EventsCRUD().deleteEvent(index);
                                  eventMap.remove(keysevents[index]);
                                  keysevents.remove(keysevents[index]);
                                  keynotfierevents.value = [...keysevents];
                                  search;
                                  AwesomeNotifications().cancel(index);
                                  Navigator.of(context).pop();
                                },
                                text: 'confirm',
                                buttoncolor:
                                    const MaterialStatePropertyAll(canvasColor),
                                textcolor: white),
                            customButton(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                },
                                text: 'cancel',
                                buttoncolor:
                                    const MaterialStatePropertyAll(light),
                                textcolor: white)
                          ],
                        ),
                      );
                    }
                  },
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('delete'),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: visible,
                builder: (context, value, child) {
                  return Visibility(
                      visible: value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8),
                            child: Text(
                                'Date: ${month[date.month]} ${date.day} , ${date.year}'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8),
                            child: Text(
                                'Time: ${eventMap[keysevents[index]]!.time}'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8),
                            child: Text(
                                'Description: ${eventMap[keysevents[index]]!.description}'),
                          )
                        ],
                      ));
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
