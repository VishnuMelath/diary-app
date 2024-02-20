import 'dart:io';

import 'package:flutter/material.dart';

List<Widget> imagewidgetlist(
    List<String> paths, Function(int) removeImageCallback) {
  return paths
      .map((e) => Stack(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.file(
                  File(e),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // print('delete image from List');
                    removeImageCallback(paths.indexOf(e));
                  },
                  child: const ColoredBox(
                    color: Colors.red,
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ))
      .toList();
}
