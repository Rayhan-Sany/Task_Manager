import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/widgets/update_profile_screen_widgets/update_profile_screen_widgets.dart';
import '../screens/auth/sign_in_screen.dart';

class AppDefaultAppBar {
  static AppBar appBar({bool isNotInProfileScreen = true}) => AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            if (isNotInProfileScreen) {
              Navigator.push(
                  TaskManager.globalKey.currentContext!,
                  MaterialPageRoute(
                      builder: (context) => const UpdateProfileScreen()));
            } else {
              UpdateProfileScreenWidgets.onTapProfileWidgetSnackBar(
                  TaskManager.globalKey.currentContext!);
            }
          },
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.dfstudio.com/digital-image-size-and-resolution-what-do-you-need-to-know"),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rayhan Sany'),
                  Text(
                    'rayhansany2@gmail.com',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        TaskManager.globalKey.currentContext!,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                        (route) => false);
                    AuthController.clearUserData();
                  },
                  icon: const Icon(Icons.logout),
                  color: Colors.white),
            ],
          ),
        ),
      );
}
