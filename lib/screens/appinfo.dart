import 'package:diaryapp/themes/themes.dart';
import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App info',style: head2,)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [ 
            const SizedBox(height: 50,),
            const Text('Diary',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            const SizedBox(height: 10,),
            const Text('version:1.0.0'),
            const SizedBox(height: 10,),
            Image.asset('assets/images/diary1.png',width: 100,),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: const Text('   My Personal Diary is a secure and private diary app designed for Android users who value offline privacy. This app allows you to chronicle your daily events, milestones, and upcoming plans in a personal and secure environment without relying on any external servers.',
              style: TextStyle(letterSpacing: 2),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}