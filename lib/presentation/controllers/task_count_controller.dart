import 'package:get/get.dart';
import 'package:task_manager/data/models/taskCount_by_status_data.dart';

import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/task_status_count_response.dart';
import '../../data/services/network_caller.dart';

class TaskCountController extends GetxController{
  TaskStatusCountResponse taskStatusCountResponse = TaskStatusCountResponse();
  List<TaskCountByStatusData> taskByStatusCountList=[];
  bool _getTaskCountByStatusInProgress = false;
  String? _errorMessage;
  bool get isGetTaskCountByStatusInProgress =>_getTaskCountByStatusInProgress;
  String get getErrorMessage =>_errorMessage??'Get Task Card List Has been failed';
  List<TaskCountByStatusData> get getListOfTaskCountData =>taskByStatusCountList;
  Future<bool> getTaskCountByStatus() async{
    _getTaskCountByStatusInProgress = true;
    bool isSuccess=false;
    update();
    final responseObject = await NetworkCaller.getRequest(Url.taskStatusCountUrl);
    if (responseObject.isSuccess) {
      taskStatusCountResponse =
          TaskStatusCountResponse.fromJson(responseObject.body);
      taskByStatusCountList =taskStatusCountResponse.listOfTaskByStatusData??[];
      isSuccess=true;
    }
    else {
      _errorMessage = responseObject.errorMassage??'Get Task Count Has been failed';
    }
    _getTaskCountByStatusInProgress = false;
    update();
    return isSuccess;
  }

}