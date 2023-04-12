import 'package:flutter/material.dart';

//light mode colors
const kPrimaryColor = Color(0xFF2377FC);
const kPrimaryColorDark = Color(0xFF0A244C);
const kElevatedBtnPressedColor = Color(0xFF0354d3);
const kTextBtnPressedColor = Color(0xFFF0F0F0);
const kBackgroundColor = Color.fromARGB(255, 255, 255, 255);
const kBlackLight = Color(0xFF2E2E2E);
const kFocusBorder = Color(0xFF7caefd);
const kIconGrey = Color(0xFF808080);
const kBorderGrey = Color(0xFF8a8a8a);
const kHintGrey = Color(0xFFA8A8A8);
const kWhiteDark = Color(0xFFF5F5F5);
const kWhiteDarker = Color(0xFFe6e6e6);
const kDestinationMarkerRed = Color(0xFFDE5246);

ThemeData lightTheme = ThemeData(
  dividerColor: kBorderGrey,
  scaffoldBackgroundColor: kBackgroundColor,
  primaryColor: kPrimaryColor,
  primaryColorDark: kPrimaryColorDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: kBackgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: kBlackLight,
    )
  ),
  fontFamily: 'Poppins',
  elevatedButtonTheme: _getElevatedButtonTheme(
      darkColor: kElevatedBtnPressedColor, lightColor: kPrimaryColor),
  textButtonTheme: _getTextButtonTheme(
      darkColor: kTextBtnPressedColor, lightColor: Colors.white),
  textTheme: _textTheme.apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: kHintGrey,
      fontWeight: FontWeight.w300,
    ),
    border: UnderlineInputBorder(borderSide: BorderSide(color: kBorderGrey)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: kBorderGrey)),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: kFocusBorder,
      ),
    ),
  ),
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

const _textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ),
  displayMedium: TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
  ),
  displaySmall: TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineSmall: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  ),
  bodyLarge: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
);
