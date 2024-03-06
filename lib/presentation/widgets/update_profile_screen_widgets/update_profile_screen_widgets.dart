import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';

class UpdateProfileScreenWidgets {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      onTapProfileWidgetSnackBar(BuildContext context) {
    return commonSnackBar(context,'You Already in Update Profile Screen');
  }
}
