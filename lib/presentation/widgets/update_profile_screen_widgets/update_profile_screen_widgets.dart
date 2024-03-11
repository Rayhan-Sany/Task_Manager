import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';

class UpdateProfileScreenWidgets {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      onTapProfileWidgetSnackBar(BuildContext context) {
    return commonSnackBar(context:context,snackBarContent:'You Already in Update Profile Screen');
  }
}
