import 'package:diaryapp/themes/themes.dart';
import 'package:flutter/material.dart';

Widget customSearch(
    {required TextEditingController search,
    required ValueNotifier searchnotifier,
    required ValueNotifier dropdownvalue,
    required VoidCallback searchfn}) {
  final List<String> categorylist = <String>[
    'All',
    'Family',
    'Friends',
    'Work',
    'Trip',
    'other'
  ];
  return ValueListenableBuilder(
      valueListenable: searchnotifier,
      builder: (context, visible, child) {
        return Visibility(
          visible: searchnotifier.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        onChanged: (value) {
                          searchfn();
                        },
                        controller: search,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 88, 119, 149)),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.white54)),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 179, 179, 179)),
                            hintText: 'Search',
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide.none))),
                  ),
                  ValueListenableBuilder(
                      valueListenable: dropdownvalue,
                      builder: (context, ddvalue, child) {
                        return DropdownButton(
                            underline: const SizedBox(),
                            dropdownColor:
                                const Color.fromRGBO(228, 234, 248, 1),
                            borderRadius: BorderRadius.circular(15),
                            hint: Text(
                              dropdownvalue.value,
                              style: const TextStyle(color: canvasColor),
                            ),
                            items: categorylist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: canvasColor),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              dropdownvalue.value = value!;
                              searchfn();
                            });
                      })
                ],
              ),
            ),
          ),
        );
      });
}
