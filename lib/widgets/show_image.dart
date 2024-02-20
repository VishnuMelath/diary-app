import 'dart:io';

import 'package:diaryapp/themes/themes.dart';
import 'package:flutter/material.dart';

Widget showImage(List<String> images, BuildContext context) {
  List<Widget> selectImages() {
    return images
        .map((e) => GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: canvasColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: light,
                                )),
                          ),
                          Expanded(
                            child: PageView(
                              controller: PageController(
                                  initialPage: images.indexOf(e)),
                              children: [
                                ...images
                                    .map((image) => Image.file(File(image)))
                                    .toList()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)
                   ,image: DecorationImage(image: FileImage(File(e)),
                   fit: BoxFit.cover
                   )
                        
                   ),
                                
                  ),
                ),
              ),
            ))
        .toList();
  }

  return GridView(
    // scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    primary: false,
    padding: const EdgeInsets.all(4),
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
    children: [
      ...selectImages(),
    ],
  );
}
