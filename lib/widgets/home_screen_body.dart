import 'package:flutter/material.dart';

Widget homeScreenBody() {
  return CustomScrollView(scrollDirection: Axis.vertical, slivers: [
    const SliverAppBar(
      floating: true,
    ),
    SliverList(delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: 50,
          ),
        );
      },
    ))
  ]);
}
