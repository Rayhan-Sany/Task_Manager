import 'package:flutter/material.dart';
import 'package:task_manager/presentation/utils/app_color.dart';

class AllWidgetStyle{

  static TextStyle heading1TextStyle(BuildContext context) {
    return const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800
    );
  }
  static TextStyle heading4TextStyle(BuildContext context) {
    return const TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 15,
    );
  }
  static TextStyle hintTextTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 13,
      color: Colors.black.withOpacity(0.4),
    );
  }

  static ButtonStyle elevatedButtonStyle(){
    return  ElevatedButton.styleFrom(
      backgroundColor:AppColor.textButtonColor,
      foregroundColor: Colors.white,
      minimumSize:const Size(double.infinity,40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
    );
  }

  static ButtonStyle textButtonStyle() {
    return TextButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      foregroundColor:AppColor.textButtonColor,
      alignment: Alignment.centerLeft,
      padding:const EdgeInsets.all(3),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w800,
      ),
    );
  }
}