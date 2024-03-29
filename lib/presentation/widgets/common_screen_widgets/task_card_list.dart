import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/presentation/controllers/task_list_controller.dart';
import 'package:task_manager/presentation/widgets/common_screen_widgets/task_card.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import '../../../data/models/taskByStatusData.dart';

class TaskCardList extends StatefulWidget {
  final String status;

  const TaskCardList({super.key, required this.status});

  @override
  State<TaskCardList> createState() => _TaskCardListState();
}

class _TaskCardListState extends State<TaskCardList> {
  List<TaskByStatusData> taskByStatusDataList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskByStatusData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskListController>(builder: (taskListController) {
      return Visibility(
        visible: taskListController.isGetTaskListInProgress==false,
        replacement:const Center(child: CircularProgressIndicator()),
        child: Visibility(
          visible: taskByStatusDataList.isNotEmpty,
          replacement: const Center(
            child: Text('No Task Added', style: TextStyle(fontSize: 20)),
          ),
          child: ListView.builder(
            itemBuilder: (context, index) => TaskCard(
              taskByStatusData: taskByStatusDataList[index],
              deleteTaskLocally: () {
                Get.find<TaskListController>().deleteTaskFromListLocally(index);
              },
            ),
            shrinkWrap: true,
            itemCount: taskByStatusDataList.length ?? 0,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
        ),
      );
    });
  }


  Future<void> _getTaskByStatusData() async {

    bool result =
        await Get.find<TaskListController>().getTaskListByStatus(widget.status);
    if (result) {
      taskByStatusDataList = Get.find<TaskListController>().taskListByStatus;
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent: Get.find<TaskListController>().getErrorMessage);
      }
    }
  }
}
