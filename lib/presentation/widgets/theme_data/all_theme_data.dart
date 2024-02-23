import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/styles/all_widget_style.dart';
class AllThemeData{
  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: TextStyle(
        color:Colors.black.withOpacity(0.35),
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
      enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:  BorderSide(
          color: Colors.red[800]!
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.red[800]!
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Color(0xFF21BF73),
        ),
      ),
      fillColor: Colors.white,
      filled: true,
      contentPadding:const EdgeInsets.only(left: 12,top: 0,bottom: 0),
      labelStyle: TextStyle(
        color: Colors.black.withOpacity(0.3),
        fontSize: 15,
      ),

    );
  }
  static TextTheme textTheme(BuildContext context){
    return TextTheme(
      titleLarge: AllWidgetStyle.heading1TextStyle(context),
      titleMedium: AllWidgetStyle.heading4TextStyle(context),
      titleSmall: AllWidgetStyle.hintTextTextStyle(context),
    );
  }

  static ElevatedButtonThemeData elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style:AllWidgetStyle.elevatedButtonStyle(),
    );
  }
  static TextButtonThemeData textButtonThemeData() {
    return TextButtonThemeData(
      style: AllWidgetStyle.textButtonStyle(),
    );
  }

}