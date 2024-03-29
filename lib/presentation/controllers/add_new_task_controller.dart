import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

class AddNewTaskController extends GetxController{
  bool _inProgress = false;
  bool isSuccess=false;
  String? errorMessage;
  String get getErrorMessage =>errorMessage?? 'Add New Task Failed';
  bool get isAddTaskInInProgress=>_inProgress;
  Future<bool> addNewTask(String title,String description)async{
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "title": title,
      "description":description,
      "status": "New"
    };
    final responseObject =
    await NetworkCaller.postRequest(Url.createTaskUrl, inputParams);

    if (responseObject.isSuccess) {
      isSuccess=true;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}