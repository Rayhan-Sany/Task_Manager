import 'package:get/get.dart';
import 'package:task_manager/data/models/task_by_status_response.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/taskByStatusData.dart';
import '../../data/services/network_caller.dart';

class TaskListController extends GetxController{
  bool _getTaskListInProgress = false;
  bool _deleteTaskInProgress = false;
  String? _errorMessage;
  TaskCardResponseByStatus taskCardResponseByStatus = TaskCardResponseByStatus();
  bool get isGetTaskListInProgress =>_getTaskListInProgress;
  bool get isDeleteTaskInProgress =>_deleteTaskInProgress;
  String get getErrorMessage =>_errorMessage??'Get Task Card List Has been failed';
  List<TaskByStatusData>get taskListByStatus=>taskCardResponseByStatus.taskByStatusDataList??[];
  Future<bool> getTaskListByStatus(String status) async{
    _getTaskListInProgress = true;
    bool isSuccess=false;
    update();
    final responseObject = await NetworkCaller.getRequest(
        Url.taskCardDataByStatusUrl(status));
    if (responseObject.isSuccess) {
      taskCardResponseByStatus =
          TaskCardResponseByStatus.fromJson(responseObject.body);
      isSuccess=true;
    }
    else {
      _errorMessage = responseObject.errorMassage??'Get $status Task Card List Has been failed';
  }
    _getTaskListInProgress = false;
    update();
    return isSuccess;
}
  void deleteTaskFromListLocally(int index) {
    _deleteTaskInProgress = true;
    update();
    taskCardResponseByStatus.taskByStatusDataList?.removeAt(index);
    _deleteTaskInProgress = false;
    update();
  }
}