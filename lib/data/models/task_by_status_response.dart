import 'package:task_manager/data/models/taskByStatusData.dart';

class TaskCardResponseByStatus {
  String? status;
  List<TaskByStatusData>? taskByStatusDataList;

  TaskCardResponseByStatus({this.status, this.taskByStatusDataList});

  TaskCardResponseByStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskByStatusDataList = <TaskByStatusData>[];
      json['data'].forEach((v) {
        taskByStatusDataList!.add( TaskByStatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskByStatusDataList != null) {
      data['data'] = taskByStatusDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

