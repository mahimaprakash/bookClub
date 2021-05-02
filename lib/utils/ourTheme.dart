import 'package:flutter/material.dart';

class OurTheme {
  Color _peach = Color(0xFFF8A488);
  Color _blue = Color(0xFF45526c);
  Color _green = Color(0xFF206a5d);

  ThemeData buildTheme() {
    return ThemeData(
        canvasColor: _peach,
        primaryColor: _peach,
        accentColor: _green,
        secondaryHeaderColor: _blue,
        hintColor: _blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: _peach,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: _peach,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF206a5d)),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Color(0xFF206a5d))),
        ));
  }
}
