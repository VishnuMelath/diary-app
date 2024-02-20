import 'package:diaryapp/database/events_crud.dart';
import 'package:diaryapp/datamodels/events.dart';
import 'package:diaryapp/functions/searchfn.dart';
import 'package:diaryapp/widgets/custom_searchbar.dart';
import 'package:diaryapp/widgets/custom_sliverlist.dart';
import 'package:diaryapp/widgets/event_list.dart';
import 'package:flutter/material.dart';

import '../../database/diary_crud.dart';
import '../../datamodels/entry.dart';
import '../../themes/themes.dart';

class DiaryPage extends StatefulWidget {
 final int tabbarindex;
  const DiaryPage({super.key,required this.tabbarindex});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this,initialIndex: widget.tabbarindex);
  }

  @override
  Widget build(BuildContext context) {
    Widget image1 = loading;
    Widget image2 = loading;
    ValueNotifier<bool> favnotifier = ValueNotifier(true);
    ValueNotifier<List> keynotfierdiary = ValueNotifier([]);
    ValueNotifier<List> keynotfierevents = ValueNotifier([]);
    List keysdiary = [];
    List keysevents = [];
    Map<dynamic, Entry> entryMap = {};
    Map<dynamic, Events> eventMap = {};
     EntryCRUD().getAllEntry().then((value) {
      image1 = empty;
      keysdiary = value.keys.toList();
      entryMap = value;
      keynotfierdiary.value = [...keysdiary];
    });
    EventsCRUD().getAllEvents().then((value) {
      image2 = empty;
      DateTime today=DateTime.now();
      DateTime today1=DateTime(today.year,today.month,today.day,0,0,0);
      value.forEach((key, value) { 
        if(value.date.isAfter(today1)){
          keysevents.add(key);
        }
      });
      // keysevents = value.keys.toList();
      eventMap = value;
      keynotfierevents.value = [...keysevents];
    });
    TextEditingController search = TextEditingController();
    ValueNotifier searchnotifier = ValueNotifier(false);
    ValueNotifier<String> dropdownvalue = ValueNotifier('Category');
    //search functions
    searchfn() {
      keysdiary = [
        ...searchEntryfn(
            dropdownvalue: dropdownvalue.value,
            search: search.text,
            entryMap: entryMap)
      ];
      if (keysdiary.isEmpty) {
        image1 = noentries;
      }
      keynotfierdiary.value = [...keysdiary];
      keysevents = [
        ...searchEventsfn(search: search.text, eventsMap: eventMap)
      ];
      if (keysevents.isEmpty) {
        image2 = noentries;
      }
      keynotfierevents.value = [...keysevents];
    }
    return CustomScrollView(
        key: UniqueKey(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customSearch(
                        search: search,
                        searchnotifier: searchnotifier,
                        dropdownvalue: dropdownvalue,
                        searchfn: searchfn),
                    TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: white,
                      dividerColor: canvasColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: _tabController,
                      indicatorColor: white,
                      tabs: const <Widget>[
                        Tab(
                          child: Text('Diary'),
                        ),
                        Tab(
                          child: Text('Upcoming Events'),
                        ),
                      ],
                    ),
                  ],
                )),
            centerTitle: true,
            stretch: true,
            expandedHeight: 150,
            floating: true,
            pinned: false,
            title: Text("Diary", style: head2),
            flexibleSpace: Image.asset(
              'assets/images/mountain-4823516_1280.png',
              fit: BoxFit.fill,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    searchnotifier.value = !searchnotifier.value;
                  },
                  icon: const Icon(
                    Icons.search,
                    color: canvasColor,
                    size: 30,
                  ))
            ],
          ),
          SliverFillRemaining(
            child: TabBarView(controller: _tabController, children: [
              ValueListenableBuilder(
                  valueListenable: keynotfierdiary,
                  builder: (context, val, child) {
                    if (keynotfierdiary.value.isNotEmpty) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          ...customSliverList(
                            keynotfierdiary: keynotfierdiary,
                              search: searchfn,
                              favnotifier: favnotifier,
                              keys: keysdiary,
                              entryMap: entryMap,
                              context: context,
                              barindex: 0),
                        ],
                      );
                    } else {
                      return image1;
                    }
                  }),
              ValueListenableBuilder(
                  valueListenable: keynotfierevents,
                  builder: (context, val, child) {
                    if (keynotfierevents.value.isNotEmpty) {
                      return eventList(keynotfierevents: keynotfierevents
                      ,eventMap: eventMap, 
                      search: searchfn, 
                      context: context, barindex: 0, 
                      keysevents: keysevents);
                    } else {
                      return image2;
                    }
                  }),
            ]),
          ),
        ]);
  }
}
