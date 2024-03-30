import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager/presentation/controllers/deleteTaskController.dart';
import 'package:task_manager/presentation/controllers/email_verification_controller.dart';
import 'package:task_manager/presentation/controllers/pin_verification_controller.dart';
import 'package:task_manager/presentation/controllers/profile_appbar_Controller.dart';
import 'package:task_manager/presentation/controllers/set_password_controller.dart';
import 'package:task_manager/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager/presentation/controllers/sign_up_controller.dart';
import 'package:task_manager/presentation/controllers/task_count_controller.dart';
import 'package:task_manager/presentation/controllers/task_list_controller.dart';
import 'package:task_manager/presentation/controllers/update_profile_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(),fenix: true);
    Get.lazyPut(() => SignUpController(),fenix:true);
    Get.lazyPut(() => TaskListController(),fenix:true);
    Get.lazyPut(() => AddNewTaskController(),fenix:true);
    Get.lazyPut(() => TaskCountController(),fenix:true);
    Get.lazyPut(() => DeleteTaskController(),fenix:true);
    Get.lazyPut(() => TaskListController(),fenix:true);
    Get.lazyPut(() => SetPasswordController(),fenix:true);
    Get.lazyPut(() => PinVerificationController(),fenix:true);
    Get.lazyPut(() => EmailVerificationController(),fenix:true);
    Get.lazyPut(() => UpdateProfileController(),fenix:true);
    Get.lazyPut(() => ProfileAppBarController(),fenix:true);
  }

}