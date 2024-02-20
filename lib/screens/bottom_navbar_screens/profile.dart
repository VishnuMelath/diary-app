import 'dart:io';
import 'package:diaryapp/database/diary_crud.dart';
import 'package:diaryapp/database/events_crud.dart';
import 'package:diaryapp/database/user_crud.dart';
import 'package:diaryapp/themes/themes.dart';
import 'package:diaryapp/widgets/custom_sheet_contents.dart';
import 'package:flutter/material.dart';
import '../../datamodels/user.dart';

int entryCount = 0;
int favCount = 0;
int eventcount=0;
ValueNotifier<User> user = ValueNotifier(User(
    name: '',
    gender: '',
    dob: DateTime.now(),
    pin: 1,
    question: '',
    answer: 'answer'));

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    getDetails().then((value) {
      user.value = value;
    });
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: user,
            builder: (context, userval, _) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    title: Text(
                      'Hi ${userval.name}',
                      style: head2,
                    ),
                    expandedHeight: 150,
                    flexibleSpace: Image.asset(
                        'assets/images/mountain-4823516_1280.png',
                        fit: BoxFit.fill),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            showModalBottomSheet(
                                showDragHandle: true,
                                backgroundColor: canvasColor,
                                barrierColor: canvasColor.withOpacity(.70),
                                useSafeArea: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: canvasColor,
                                    child: customSheetContents(context, user),
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: canvasColor,
                            size: 30,
                          ))
                    ],
                    bottom: PreferredSize(
                      preferredSize:
                          Size(MediaQuery.of(context).size.width, 50),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: userval.image == null
                            ? CircleAvatar(
                                radius: 50,
                                child: Image.asset('assets/images/profile.png',
                                    fit: BoxFit.cover),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    FileImage(File(userval.image!)),
                              ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        margin: const EdgeInsets.all(60),
                        padding: const EdgeInsets.all(30),
                        decoration: boxDecoration1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(child: Text('Entries written')),
                                Text('$entryCount')
                              ],
                            ),
                            const Divider(),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child:
                                        Text('Favorite entries')),
                                Text('$favCount')
                              ],
                            ),const Divider(),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(child: Text('Upcoming events')),
                                Text('$eventcount')
                              ],
                            ),
                            const Divider(),
                          ],
                        )),
                  )
                ],
              );
            }),
      ),
    );
  }
}

Future<User> getDetails() async {
   entryCount = 0;
 favCount = 0;
 eventcount=0;
  User user = await getUserData();
  entryCount = await EntryCRUD().getAllEntry().then((value){
    value.forEach((key, value) {if(value.fav==true){
      favCount++;
    } });
    return value.length;});
  await EventsCRUD().getAllEvents().then((value){
    value.forEach((key, value) {
      if(DateTime.now().isBefore(value.date)){
        eventcount++;
      }
   });
    
    });
  return user;
}
