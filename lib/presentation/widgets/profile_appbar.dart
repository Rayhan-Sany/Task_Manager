import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/controllers/profile_appbar_Controller.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/widgets/update_profile_screen_widgets/update_profile_screen_widgets.dart';
import '../screens/auth/sign_in_screen.dart';

class AppDefaultAppBar {
  static List<String>? photo;
  static AppBar appBar({bool isNotInProfileScreen = true}) => AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            if (isNotInProfileScreen) {
              Get.to(()=>const UpdateProfileScreen());
              // Navigator.push(
              //     TaskManager.globalKey.currentContext!,
              //     MaterialPageRoute(
              //         builder: (context) => const UpdateProfileScreen()));
            } else {
              UpdateProfileScreenWidgets.onTapProfileWidgetSnackBar(
                  TaskManager.globalKey.currentContext!);
            }
          },
          child: GetBuilder<ProfileAppBarController>(
            builder: (profileAppBarController) {
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AppDefaultAppBar.isImageAvailable
                        ? MemoryImage(base64Decode(AuthController.userData!.photo!))
                        : MemoryImage(base64Decode(photo![1])),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AuthController.userData?.fullName ?? ''),
                      Text(
                        AuthController.userData?.email ?? '',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {
                        Get.offAll(()=>const SignIn());
                        // Navigator.pushAndRemoveUntil(
                        //     TaskManager.globalKey.currentContext!,
                        //     MaterialPageRoute(builder: (context) => const SignIn()),
                        //     (route) => false);
                        AuthController.clearUserData();
                      },
                      icon: const Icon(Icons.logout),
                      color: Colors.white),
                ],
              );
            }
          ),
        ),
      );

  static bool get isImageAvailable {
    try {
      photo = AuthController.userData!.photo!.split(',');
      base64Decode(AuthController.userData!.photo!);
      if (AuthController.userData?.photo == null) {
        return false;
      }
      if (AuthController.userData!.photo!.trim().isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
