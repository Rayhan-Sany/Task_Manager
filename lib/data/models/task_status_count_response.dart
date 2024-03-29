import 'package:task_manager/data/models/taskCount_by_status_data.dart';

class TaskStatusCountResponse {
  String? status;
  List<TaskCountByStatusData>? listOfTaskByStatusData;
  TaskStatusCountResponse({this.status, this.listOfTaskByStatusData});

  TaskStatusCountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskByStatusData = <TaskCountByStatusData>[];
      json['data'].forEach((v) {
        listOfTaskByStatusData!.add(TaskCountByStatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.listOfTaskByStatusData != null) {
      data['data'] = this.listOfTaskByStatusData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


