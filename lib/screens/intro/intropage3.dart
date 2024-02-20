import 'package:diaryapp/themes/themes.dart';
import 'package:flutter/material.dart';

import '../create_profile.dart';

class Intro3 extends StatelessWidget {
  final BuildContext context1;

  const Intro3({super.key, required this.context1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context1).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () {}, child: const Text(''))),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Image.asset(
              'assets/images/seo.png',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: const Text(
                  'Search and revisit your moments',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      color: canvasColor),
                )),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const CreateProfile(),
                        ),
                        (route) => false);
                  },
                  child: const Text('Lets Get Started')),
            ),
            // Image
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
