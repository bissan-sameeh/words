import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';

abstract class ThemeManager{
  static ThemeData getThemeData(){

    return ThemeData(
      scaffoldBackgroundColor: ColorManager.black,

      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 21,color: ColorManager.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  ColorManager.black,
        ),

      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorManager.white,

      )

    );
  }
}