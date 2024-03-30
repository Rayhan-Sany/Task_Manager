import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

class UpdateTaskStatusController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  String? _taskId;
  String get getTaskId =>_taskId??'';
  bool get isUpdateTaskStatusInProgress=>_inProgress;
  String get getErrorMessage =>_errorMessage??'Edit Task Status Failed';
  Future<bool> updateTaskStatus(String taskId,String status)async{
    _inProgress=true;
    _taskId=taskId;
    bool isSuccess=false;
    update();
    final  responseObject = await NetworkCaller.getRequest(
        Url.updateTaskStatusUrl(taskId, status));
    if(responseObject.isSuccess){
      isSuccess=true;
    }else{
      _errorMessage = responseObject.errorMassage;
    }
    _inProgress=false;
    update();
    return isSuccess;

  }

}