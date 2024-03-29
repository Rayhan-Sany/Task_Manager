import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/taskCount_by_status_data.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import '../../controllers/task_count_controller.dart';

class TaskCounterSection extends StatefulWidget {
   const TaskCounterSection({super.key});

  @override
  State<TaskCounterSection> createState() => _TaskCounterSectionState();
}

class _TaskCounterSectionState extends State<TaskCounterSection> {
  List<TaskCountByStatusData> taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GetBuilder<TaskCountController>(
              builder: (taskCountController) {
                return Visibility(
                  visible:taskCountController.isGetTaskCountByStatusInProgress==false,
                  replacement: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          color: Colors.white,
                          child: SizedBox(
                            width: 100,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "0${
                                          taskCountController.taskByStatusCountList[index].sum
                                              .toString()
                                      }",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text( taskCountController.taskByStatusCountList[index].sId ?? '',
                                    style: TextStyle(fontSize:12,color:Colors.black.withOpacity(0.6)),),
                                ],
                              ),
                            ),
                          ),
                        ),
                    separatorBuilder: (_, __) =>
                    const SizedBox(
                      width: 2,
                    ),
                    itemCount:
                    taskCountController.taskByStatusCountList.length ??
                        0,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getAllTaskCountByStatus() async {
    TaskCountController taskCountController = Get.find<TaskCountController>();
   final result = await taskCountController.getTaskCountByStatus();
    if (result) {
     taskStatusCountList = taskCountController.taskByStatusCountList;
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent: 'Task Count By Status Failed',
            isErrorSnack: true);
      }
    }
  }
}
