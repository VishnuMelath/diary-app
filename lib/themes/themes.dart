import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);

const Color light = Color.fromRGBO(228, 234, 248, 1);
const Color dark = canvasColor;
const MaterialStateProperty<Color> materialColorDark =
    MaterialStatePropertyAll(dark);
const MaterialStateProperty<Color> materialColorLight =
    MaterialStatePropertyAll(light);
const TextStyle head = TextStyle(
    inherit: true,
    fontSize: 30.0,
    color: dark,
    fontWeight: FontWeight.w900,
    letterSpacing: 5,
    shadows: [
      Shadow(
          // bottomLeft
          blurRadius: 10,
          offset: Offset(1, 1),
          color: canvasColor),
    ]);
TextStyle head2 = GoogleFonts.lobster(
    color: canvasColor,
    fontSize: 25,
    fontWeight: FontWeight.w900,
    shadows: [
      const Shadow(
          // bottomLeft
          blurRadius: 10,
          offset: Offset(1, 1),
          color: canvasColor),
    ]);

//input fields
// InputDecoration textfieldInputdecoration = InputDecoration(
//     hintStyle: inputfieldtextstyle,
//     hintText: 'Re-enter pin',
//     filled: true,
//     fillColor: light,
//     border: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         borderSide: BorderSide.none));
//TEXT STYLE..............................................................................
TextStyle inputfieldtextstyle = const TextStyle(
    overflow: TextOverflow.fade, color: Color.fromARGB(255, 192, 192, 192));

//INPUT DECORATION........................................................................
InputDecoration inputDecoration(String hint) {
  return InputDecoration(
    hintStyle: inputfieldtextstyle,
    hintText: hint,
    filled: true,
    fillColor: light,
    counter: const Offstage(),
    // border: const OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(20)),
    //     borderSide: BorderSide.none)
  );
}
InputDecoration textfieldInputdecoration(String hint){
return InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide.none),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 179, 179, 179)),
                              hintText: hint,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none));
} 

Widget loading = Padding(
  padding: const EdgeInsets.all(20.0),
  child: Center(
    child: Lottie.asset('assets/animation/bookloading.json'),
  ),
);
Widget empty = Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Lottie.asset('assets/animation/empty.json'),
      Text('Nothing here', style: GoogleFonts.aBeeZee()),
    ],
  ),
);
Widget noentries = Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Lottie.asset('assets/animation/empty.json'),
      Text(
        'Not found',
        style: GoogleFonts.aBeeZee(),
      ),
    ],
  ),
);

const TextStyle head1= TextStyle(fontSize: 20,fontWeight: FontWeight.w700);
const TextStyle head3= TextStyle(fontSize: 16,fontWeight: FontWeight.w500);
const BoxDecoration boxDecoration1=BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: light,
                        );
const dropdowncolor= Color.fromRGBO(228, 234, 248, 1);
const textstyletextbox=TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 15, color: canvasColor);