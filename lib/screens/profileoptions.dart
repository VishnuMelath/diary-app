import 'package:diaryapp/screens/change_pin.dart';
import 'package:diaryapp/screens/edit_profile.dart';
import 'package:diaryapp/screens/edit_security_qa.dart';
import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  final ValueNotifier user;
  const ProfileOptions({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person_2),
              title: const Text('Edit profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(user: user),));
                
              },
            ),
            const Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Edit security question and answer '),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => EditQA(user: user),));
              },
            ),
            const Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: const Icon(Icons.password_outlined),
              title: const Text('Change security pin'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePin1(user: user),));
              },
            ),const Divider(
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}
