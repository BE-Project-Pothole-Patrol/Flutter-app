import 'package:flutter/material.dart';

//light mode colors
const kPrimaryColor = Color(0xFF2377FC);
const kPrimaryColorDark = Color(0xFF0A244C);
const kElevatedBtnPressedColor = Color(0xFF0354d3);
const kTextBtnPressedColor = Color(0xFFF0F0F0);
const kBackgroundColor = Color.fromARGB(255, 255, 255, 255);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColor,
  primaryColor: kPrimaryColor,
  primaryColorDark: kPrimaryColorDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor, //use your hex code here
  ),
  fontFamily: 'Poppins',
  elevatedButtonTheme: _getElevatedButtonTheme(
      darkColor: kElevatedBtnPressedColor, lightColor: kPrimaryColor),
  textButtonTheme: _getTextButtonTheme(
      darkColor: kTextBtnPressedColor, lightColor: Colors.white),
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);

ElevatedButtonThemeData _getElevatedButtonTheme({
  required Color darkColor,
  required Color lightColor,
}) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 14, horizontal: 29),
      ),
      overlayColor: MaterialStateColor.resolveWith((states) {
        return darkColor;
      }),
      splashFactory: NoSplash.splashFactory,
      backgroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return darkColor;
        } else if (states.contains(MaterialState.disabled)) {
          return lightColor.withOpacity(0.5);
        } else if (states.contains(MaterialState.hovered)) {
          return darkColor;
        } else {
          return lightColor;
        }
      }),
      foregroundColor: MaterialStateColor.resolveWith((states) {
        return Colors.white;
      }),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        );
      }),
    ),
  );
}

TextButtonThemeData _getTextButtonTheme({
  required Color darkColor,
  required Color lightColor,
}) {
  return TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 14, horizontal: 29),
      ),
      overlayColor: MaterialStateColor.resolveWith((states) {
        return darkColor;
      }),
      splashFactory: NoSplash.splashFactory,
      backgroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return darkColor;
        } else if (states.contains(MaterialState.disabled)) {
          return lightColor.withOpacity(0.5);
        } else if (states.contains(MaterialState.hovered)) {
          return Colors.transparent;
        } else {
          return lightColor;
        }
      }),
      foregroundColor: MaterialStateColor.resolveWith((states) {
        return kPrimaryColor;
      }),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
        );
      }),
    ),
  );
}
