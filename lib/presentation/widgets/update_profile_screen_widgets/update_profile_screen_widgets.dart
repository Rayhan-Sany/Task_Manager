import 'package:flutter/material.dart';
import 'package:task_manager/presentation/utils/app_color.dart';
class UpdateProfileScreenWidgets {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> onTapProfileWidgetSnackBar(BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(
             SnackBar(content:const Text('You Already in Update Profile Screen'),backgroundColor: AppColor.baseColor,));
  }
}
