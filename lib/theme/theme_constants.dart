import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFF2377FC);
const kPrimaryColorDark = Color(0xFF0A244C);
const kBackgroundColor = Color.fromARGB(255, 255, 255, 255);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColor,
  primaryColor: kPrimaryColor,
  primaryColorDark: kPrimaryColorDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor, //use your hex code here
  ),
  fontFamily: 'Poppins'
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
