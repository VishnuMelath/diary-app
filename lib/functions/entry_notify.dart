// import 'package:android_alarm_manager/android_alarm_manager.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:diaryapp/database/diary_crud.dart';

// Future<void> notifyuser()
// async{
//   await AndroidAlarmManager.periodic(Duration(days: 1), 1, sendNotification(),startAt: DateTime(2024,2,15,20,0,0));
// }

// sendNotification() async{
//   DateTime today=DateTime.now();
//   final date=DateTime(today.year,today.month,today.day);
//   await EntryCRUD().getAllEntry().then((value) {
//     value.forEach((key, value) async{
//       var date2=DateTime(value.date.year,value.date.month,value.date.day);
//       if(date==date2){
//         await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 0,
//         channelKey: 'diary_channel',
//         title: 'Notification',
//         body: 'you didn\'t wrote any entry today.',
//       ),
//     );
//       } });
//    });
//   print(date);
  
// }
// void main()
// {sendNotification();

// }