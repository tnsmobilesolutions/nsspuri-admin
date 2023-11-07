// app_theme.dart

import 'package:flutter/material.dart';
import 'package:sdp/utilities/color_palette.dart';

final ThemeData appTheme = ThemeData(
    primaryColor: Colors.deepOrange, // Set your primary color
    hintColor: Colors.grey, // Set your accent color
    textTheme: const TextTheme(

        // Define your text styles here
        headlineSmall: TextStyle(),
        bodyLarge: TextStyle(),
        bodySmall: TextStyle(),
        // use for textformField
        displaySmall: TextStyle(),
        // use for cards
        displayMedium: TextStyle(
            fontSize: 14, color: TextThemeColor, fontWeight: FontWeight.bold),
        displayLarge: TextStyle(),
        // use for button text
        titleSmall: TextStyle(
            fontSize: 14,
            color: ButtonTextStyleColor,
            fontWeight: FontWeight.bold),
        // use for appBar
        titleMedium: TextStyle(
            fontSize: 20, color: TextThemeColor, fontWeight: FontWeight.w300),
        titleLarge: TextStyle()),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all(Colors.deepOrange), // Text color
      backgroundColor: MaterialStateProperty.all(
          ScaffoldBackgroundColor), // Background color
      padding: MaterialStateProperty.all(EdgeInsets.all(16)), // Padding
      textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 16), // Text style
      ),
    ))
    // Define other theme properties here
    );
