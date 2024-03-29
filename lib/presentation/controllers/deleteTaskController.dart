import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

class DeleteTaskController extends GetxController{
  bool _taskDeleteInProgress=false;
  String? _errorMessage;
  String? taskId;
  bool get isTaskDeleteInProgress =>_taskDeleteInProgress;
  String get getErrorMessage =>_errorMessage??'Task Delete Failed';
  Future<bool> deleteTask(String taskId) async {
    _taskDeleteInProgress = true;
    this.taskId=taskId;
    bool isSuccess=false;
    update();
    final responseObject = await NetworkCaller.getRequest(
        Url.deleteTaskUrl(taskId));
    if (responseObject.isSuccess) {
      isSuccess=true;
      } else {
        _errorMessage = responseObject.errorMassage??'Task Delete Failed';
      }
    _taskDeleteInProgress = false;
    update();
    return isSuccess;
    }
  }
