import 'package:diaryapp/themes/themes.dart';
import 'package:flutter/material.dart';

import '../create_profile.dart';

class Intro1 extends StatelessWidget {
  final BuildContext context1;

  const Intro1({super.key, required this.context1});

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
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const CreateProfile(),
                            ),
                            (route) => false);
                      },
                      child: const Text('skip>>>'))),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Image.asset(
              'assets/images/shield.png',
              width: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: const Text(
                  'Safeguard Your Memories',
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
