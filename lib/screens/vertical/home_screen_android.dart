import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diaryapp/screens/bottom_navbar_screens/addentry.dart';
import 'package:diaryapp/screens/bottom_navbar_screens/calender.dart';
import 'package:diaryapp/screens/bottom_navbar_screens/diarypage.dart';
import 'package:diaryapp/screens/bottom_navbar_screens/favorites.dart';
import 'package:diaryapp/screens/bottom_navbar_screens/profile.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class HomeScreenPhone extends StatelessWidget {
  final int index;
  final int tabbarindex;
  const HomeScreenPhone({super.key, required this.index, required this.tabbarindex});

  @override
  Widget build(BuildContext context) {
  
    ValueNotifier<int> selectedIndex = ValueNotifier(index);
    List<Widget> screens = [
       DiaryPage(tabbarindex:tabbarindex,),
      const Favorites(),
      AddDay(
        index: selectedIndex.value,
      ),
      const CalenderPage(),
      const Profile()
    ];

    return Container(
      color: canvasColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            index: index,
            height: 50,
            animationCurve: Easing.legacy,
            color: canvasColor,
            buttonBackgroundColor: canvasColor,
            backgroundColor: Colors.transparent,
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: white,
              ),
              Icon(
                Icons.favorite,
                size: 30,
                color: white,
              ),
              Icon(
                Icons.add,
                size: 30,
                color: white,
              ),
              Icon(
                Icons.calendar_month,
                size: 30,
                color: white,
              ),
              Icon(
                Icons.person,
                size: 30,
                color: white,
              ),
            ],
            onTap: (indextapped) {
              //Handle button tap
              selectedIndex.value = indextapped;
            },
          ),
          body: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, value, child) {
                return screens[selectedIndex.value];
              }),
        ),
      ),
    );
  }
}
