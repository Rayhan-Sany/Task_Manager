import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager/presentation/controllers/deleteTaskController.dart';
import 'package:task_manager/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager/presentation/controllers/task_count_controller.dart';
import 'package:task_manager/presentation/controllers/task_list_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => TaskListController());
    Get.lazyPut(() => AddNewTaskController());
    Get.put(() => TaskListController());
    Get.lazyPut(() => TaskCountController());
    Get.lazyPut(() => DeleteTaskController());
  }

}