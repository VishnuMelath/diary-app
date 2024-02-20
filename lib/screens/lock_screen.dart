import 'package:diaryapp/screens/forgot_pin.dart';
import 'package:diaryapp/screens/vertical/home_screen_android.dart';
import 'package:flutter/material.dart';

import '../database/user_crud.dart';
import '../themes/themes.dart';
import '../widgets/custom_keypad.dart';

const TextStyle textStyle1 = TextStyle(
  color: dark,
);
List<Color> color1 = [light, light, light, light];
ValueNotifier<List<Color>> color = ValueNotifier([light, light, light, light]);
ValueNotifier<bool> visible = ValueNotifier(false);
int count = 0;
String pin = '';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Expanded(
                child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  'ENTER PASSCODE',
                  style: TextStyle(
                      color: dark,
                      fontSize: 20,
                      letterSpacing: 5,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: ValueListenableBuilder(
                  valueListenable: color,
                  builder: (context, value, child) {
                    return customPinbar(color);
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ValueListenableBuilder(
                  valueListenable: visible,
                  builder: (context, val, child) {
                    return Visibility(
                      visible: val,
                      child: const Text(
                        'wrong pin!!',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('1', context);
                              },
                              child: customKeypad(const Text('1'))),
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('2', context);
                              },
                              child: customKeypad(const Text('2'))),
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('3', context);
                              },
                              child: customKeypad(const Text('3'))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('4', context);
                              },
                              child: customKeypad(const Text('4'))),
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('5', context);
                              },
                              child: customKeypad(const Text('5'))),
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('6', context);
                              },
                              child: customKeypad(const Text('6'))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('7', context);
                              },
                              child: customKeypad(const Text('7'))),
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('8', context);
                              },
                              child: customKeypad(const Text('8'))),
                          GestureDetector(
                              onTap: () async {
                                await ontapfn('9', context);
                              },
                              child: customKeypad(const Text('9'))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                count = 0;
                                color.value = [light, light, light, light];
                                visible.value = false;
                              },
                              child: customKeypad(const Text('0'))),
                          GestureDetector(
                            onTap: () async {
                              await ontapfn('0', context);
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 10,
                              color: Colors.transparent,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    color: light,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: const Center(
                                    child: Text(
                                  '0',
                                  style: textStyle1,
                                )),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (count > 0) {
                                count--;
                                color1[count] = light;
                                color.value = [...color1];

                                pin = pin.replaceFirst(pin[count], '', count);
                                visible.value = false;
                              }
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 10,
                              color: Colors.transparent,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: light,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                    child: Icon(
                                  Icons.backspace_outlined,
                                  color: dark,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPin(),
                                  ));
                            },
                            child: const Text(
                              'forgot pin?',
                              style: TextStyle(color: canvasColor),
                            )),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  verify(String pin, ValueNotifier visible, BuildContext context) async {
    var pins = int.parse(pin);
    getPin().then((pina) {
      if (pina == pins) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeScreenPhone(
                      index: 0,
                      tabbarindex: 0,
                    )));
      } else {
        visible.value = true;
      }
    });
    await Future.delayed(const Duration(milliseconds: 30));
  }

  ontapfn(String num, BuildContext context) async {
    visible.value = false;
    if (count < 4) {
      count++;
      pin = '$pin$num';
      color1[count - 1] = dark;
      color.value = [...color1];

      if (count == 4) {
        await verify(pin, visible, context);

        pin = '';
        count = 0;
        color1 = [light, light, light, light];
        color.value = [light, light, light, light];
      }
    }
  }
}
