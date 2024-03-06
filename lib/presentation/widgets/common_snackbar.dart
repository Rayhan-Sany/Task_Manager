import 'package:flutter/material.dart';

import '../utils/app_color.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> commonSnackBar(BuildContext context,String snackBarContent) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(
      SnackBar(content: Text(snackBarContent),backgroundColor: AppColor.baseColor,));
}