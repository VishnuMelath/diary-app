import 'package:diaryapp/screens/appinfo.dart';
import 'package:diaryapp/screens/privacy_policy.dart';
import 'package:diaryapp/screens/profileoptions.dart';
import 'package:flutter/material.dart';


Widget customSheetContents(BuildContext context,ValueNotifier user) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return ProfileOptions(user: user);
          },)).then((value) {
            Navigator.pop(context);
          });
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: const Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Profile',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
     
      InkWell(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const PrivacyPolicy(),));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: const Row(
            children: [
              Icon(
                Icons.list_alt,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Privacy policy',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const AppInfo(),));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: const Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'App info',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
