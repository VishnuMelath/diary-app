import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../database/user_crud.dart';
import '../datamodels/entry.dart';
import '../datamodels/events.dart';
import '../datamodels/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animation/Animation - 1705898282532.json',
          width: 200,
          animate: true,
          repeat: false,
          reverse: false,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(() async {
                await wait(context);
              });
          },
        ),
      ),
    );
  }
}

wait(BuildContext context) async {
  // await notifyuser();
  bool permissionStatus=await AwesomeNotifications().isNotificationAllowed();
if(!permissionStatus)
{
 await AwesomeNotifications().requestPermissionToSendNotifications();
} 
  

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(EntryAdapter());
  Hive.registerAdapter(EventsAdapter());
  await checkLogged().then((value) {
    if (value >= 1) {
      Navigator.pushReplacementNamed(context, 'lock');
    } else {
      Navigator.pushReplacementNamed(context, 'intro');
    }
  });
}
