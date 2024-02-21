import 'package:diaryapp/database/diary_crud.dart';
import 'package:diaryapp/screens/edit_entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../datamodels/entry.dart';
import '../datamodels/globaldatas.dart';
import '../themes/themes.dart';
import 'custom_button.dart';
import 'show_image.dart';

List<Widget> customSliverList(
    {required ValueNotifier favnotifier,
    required List keys,
    required Map<dynamic, Entry> entryMap,
    required VoidCallback search,
    required ValueNotifier keynotfierdiary,
    required BuildContext context,
    required int barindex}) {
     
  List<Widget> list = [];
  for (var index in keys) {
     ValueNotifier<bool> visible=ValueNotifier(false);
    DateTime date = entryMap[index]!.date;
    list.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            // color: light,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  visible.value=!visible.value;
                },
                child: ListTile(
                  title: Text(
                    entryMap[index]!.title,
                    style: GoogleFonts.blackOpsOne(fontSize: 20),
                  ),
                  subtitle:
                      Text('${month[date.month]} ${date.day} , ${date.year}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: favnotifier,
                          builder: (context, fav, child) {
                            return entryMap[index]!.fav == false
                                ? IconButton(
                                    onPressed: () async {
                                      entryMap[index]!.fav = true;
                                      await EntryCRUD()
                                          .updateEntry(index, entryMap[index]!);
                                      entryMap[index]!.fav = true;
                                      favnotifier.value = !favnotifier.value;
                                    },
                                    icon: const Icon(Icons.favorite_border))
                                : IconButton(
                                    onPressed: () async {
                                      entryMap[index]!.fav = false;
                                      await EntryCRUD()
                                          .updateEntry(index, entryMap[index]!);
                                      entryMap[index]!.fav = false;
                                      favnotifier.value = !favnotifier.value;
                                      Future.delayed(
                                          const Duration(milliseconds: 70),
                                          search);
                                    },
                                    icon: const Icon(Icons.favorite));
                          }),
                      PopupMenuButton(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEntry(
                                    entryval: entryMap[index]!,
                                    index: index,
                                    barindex: barindex,
                                  ),
                                ));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete'),
                                 content: Text('are you sure?'),
                                actions: [
                                  customButton(
                                      onTap: () async {
                                        await EntryCRUD().deleteEntry(index);
                                        keys.remove(index);
                                        keynotfierdiary.value = [...keys];
                                        search;
                                        Navigator.of(context).pop();
                                      },
                                      text: 'confirm',
                                      buttoncolor: const MaterialStatePropertyAll(
                                          canvasColor),
                                      textcolor: white),
                                  customButton(
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                      },
                                      text: 'cancel',
                                      buttoncolor:
                                          const MaterialStatePropertyAll(light),
                                      textcolor: white)
                                ],
                              ),
                            );
                          }
                        },
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('delete'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: visible,
                builder: (context,value,_) {
                  return Visibility(
                    visible: value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [ const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                      child: ReadMoreText(
                        entryMap[index]!.entry,
                        trimLines: 1,
                        trimMode: TrimMode.Line,
                        style: const TextStyle(
                            fontSize: 15, color: dark, fontWeight: FontWeight.w300),
                      ),
                    ),
                    if (entryMap[index]!.images.isNotEmpty)
                      showImage(entryMap[index]!.images, context)],
                    ),
                  );
                }
              )
              ,
             
            ],
          ),
        ),
      ),
    ));
  }
  return list;
}
