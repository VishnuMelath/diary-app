import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:diaryapp/screens/intro/intro.dart';
import 'package:diaryapp/screens/lock_screen.dart';
import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/vertical/home_screen_android.dart';
import 'themes/themes.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications awesomeNotifications =AwesomeNotifications();

   await awesomeNotifications.initialize('resource://drawable/res_app_icon', [
    NotificationChannel(
        channelGroupKey: 'test_group',
        channelKey: 'diary_channel',
        channelName: 'diary channel',
        channelDescription: 'test notification')
  ],debug:true 
  , channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'test_group', channelGroupName: 'test group')
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: canvasColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        'homephone': (context) => const HomeScreenPhone(
              index: 0,
              tabbarindex: 0,
            ),
        'intro': (context) => const IntroPageView(),
        'lock': (context) => const LockScreen()
      },
    );
  }
}
