import 'package:flutter/material.dart';

import '../utils/app_color.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> commonSnackBar({
    required BuildContext context, required String snackBarContent,bool isErrorSnack=false}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(snackBarContent),
    backgroundColor: isErrorSnack?Colors.red:AppColor.baseColor,
  ));
}
