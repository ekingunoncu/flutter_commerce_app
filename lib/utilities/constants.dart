import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

const MaterialColor lightGreen = MaterialColor(
  _lightGreenPrimaryValue,
  <int, Color>{
    50: Color(0xff92d2c5),
    100: Color(0xFFBBDEFB),
    200: Color(0xffa1d9cd),
    300: Color(0xffa1d9cd),
    400: Color(0xffa1d9cd),
    500: Color(_lightGreenPrimaryValue),
    600: Color(0xffa1d9cd),
    700: Color(0xffa1d9cd),
    800: Color(0xffa1d9cd),
    900: Color(0xffa1d9cd),
  },
);

const int _lightGreenPrimaryValue = 0xffa1d9cd;

final kLinearGradientStyle =  LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xff92d2c5),
    Color(0xffa1d9cd),
    Color(0xffafded5),
    Color(0xffc5e7e0),
  ],
  stops: [0.1, 0.4, 0.7, 0.9],
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xfffffbd6),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Color(0xff92d2c5),
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);