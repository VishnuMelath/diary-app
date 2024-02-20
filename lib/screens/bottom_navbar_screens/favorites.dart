import 'package:flutter/material.dart';

import '../../database/diary_crud.dart';
import '../../datamodels/entry.dart';
import '../../functions/searchfn.dart';
import '../../themes/themes.dart';
import '../../widgets/custom_searchbar.dart';
import '../../widgets/custom_sliverlist.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    Widget image = loading;
    ValueNotifier<bool> favnotifier = ValueNotifier(true);
    ValueNotifier<List> keynotfier = ValueNotifier([]);
    List keys = [];
    Map<dynamic, Entry> entryMap = {};
    EntryCRUD().getAllEntry().then((value) {image=empty;
      entryMap = value;
      for (var key in entryMap.keys) {
        if (entryMap[key]!.fav == true) {
          keys.add(key);
        }
      }
      keynotfier.value = [...keys];
    });
    TextEditingController search = TextEditingController();
    ValueNotifier searchnotifier = ValueNotifier(false);
    ValueNotifier<String> dropdownvalue = ValueNotifier('Category');

    //search functions

    searchfn() {
      image = loading;
      keys = [
        ...searchEntryfavfn(
            dropdownvalue: dropdownvalue.value,
            search: search.text,
            entryMap: entryMap)
      ];
      if (keys.isEmpty) {
        image = noentries;
      }
      keynotfier.value = [...keys];
    }

    return CustomScrollView(scrollDirection: Axis.vertical, slivers: [
      SliverAppBar(
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 50),
            child: customSearch(
                search: search,
                searchnotifier: searchnotifier,
                dropdownvalue: dropdownvalue,
                searchfn: searchfn)),
        centerTitle: true,
        stretch: true,
        expandedHeight: 150,
        floating: true,
        pinned: false,
        title: Text("Favorites", style: head2),
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
      SliverList(
          delegate: SliverChildListDelegate([
        ValueListenableBuilder(
            valueListenable: keynotfier,
            builder: (context1, val, child) {
              if (keynotfier.value.isNotEmpty) {
                return Column(
                  children: [
                    ...customSliverList(
                      keynotfierdiary: keynotfier,
                        barindex: 1,
                        favnotifier: favnotifier,
                        keys: keys,
                        entryMap: entryMap,
                        search: searchfn,
                        context: context),
                  ],
                );
              } else {
                return image;
              }
            }),
      ]))
    ]);
  }
}
