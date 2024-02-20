import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:diaryapp/screens/vertical/home_screen_android.dart';
import 'package:diaryapp/widgets/add_event.dart';
import 'package:flutter/material.dart';
import '../../database/diary_crud.dart';
import '../../database/events_crud.dart';
import '../../datamodels/entry.dart';
import '../../datamodels/events.dart';
import '../../themes/themes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/entry_widget.dart';

class AddDay extends StatefulWidget {
  final int index;

  const AddDay({super.key, required this.index});

  @override
  State<AddDay> createState() => _AddDayState();
}

class _AddDayState extends State<AddDay> with TickerProviderStateMixin {

  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey1 = GlobalKey();
    GlobalKey<FormState> formkey2 = GlobalKey();
    Entry entryval = Entry(
        title: '',
        entry: '',
        date: DateTime.now(),
        images: [],
        fav: false,
        category: '');
        Events event=Events(title: '', date: DateTime.now(), description: '', location: '', time: TimeOfDay.now().format(context));
    Widget button1 = customButton(
        onTap: () async {
          if (formkey1.currentState!.validate()) {
            EntryCRUD().insetEntry(entryval).then((value) {
              
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreenPhone(index: widget.index,tabbarindex: 0,),
                  ));
            });
          }
        },
        text: 'save',
        buttoncolor: const MaterialStatePropertyAll(canvasColor),
        textcolor: white);
        //event button
        Widget button2 = customButton(
        onTap: () async {
          if (formkey2.currentState!.validate()) {
            EventsCRUD().insetEvents(event).then((value) {
            
              _scheduleNotification(event,value);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreenPhone(index: widget.index,tabbarindex: 1,),
                  ));
            });
          }
        },
        text: 'save',
        buttoncolor: const MaterialStatePropertyAll(canvasColor),
        textcolor: white);

    return Scaffold(
        body: Container(
            color: canvasColor,
            child: SafeArea(
                child: Container(
                    color: white,
                    child: CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverAppBar(
                            bottom: TabBar(
                              unselectedLabelColor: Colors.grey,
                              labelColor: white,
                              dividerColor: canvasColor,
                              dividerHeight: 5,
                              indicatorSize: TabBarIndicatorSize.tab,
                              controller: _tabController,
                              indicatorColor: white,
                              tabs: const <Widget>[
                                Tab(
                                  child: Text('Daily entry'),
                                ),
                                Tab(
                                  child: Text('Upcoming Events'),
                                ),
                              ],
                            ),
                            centerTitle: true,
                            stretch: true,
                            expandedHeight: 150,
                            floating: true,
                            pinned: false,
                            title: Text('Add', style: head2),
                            flexibleSpace: Image.asset(
                              'assets/images/mountain-4823516_1280.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SliverFillRemaining(
                            child: TabBarView(
                              controller: _tabController,
                              children: [entry(
                                  entryval, context, button1, "add entry", formkey1),
                                  addEvent(context,'add',0,button2,event,formkey2)
                                  ]
                            ),
                          ),
                        ])))));
  }
 
 }
 Future<void> _scheduleNotification(Events event,int id) async {
  DateTime date1=DateTime(event.date.year,event.date.month,event.date.day,0,0,0);
  //creating channel
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'test_group',
        channelKey: 'diary_channel$id',
        channelName: 'diary channel $id',
        channelDescription: 'test notification',playSound: true)
  ]);
  //creating notification
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'diary_channel$id',
        title: 'you have  an event today',
        body: 'you have ${event.title}  at ${event.time} .',
      ),
    schedule:  NotificationCalendar.fromDate(date: date1)
    );
  }