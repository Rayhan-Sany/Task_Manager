import 'package:flutter/material.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/models/task_status_count_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';

class TaskCounterSection extends StatefulWidget {
  bool isRequireRefresh=false;
   TaskCounterSection({super.key,required this.isRequireRefresh});

  @override
  State<TaskCounterSection> createState() => _TaskCounterSectionState();
}

class _TaskCounterSectionState extends State<TaskCounterSection> {
  bool _taskCountByStatusInProgress = false;
  TaskStatusCountResponse? taskStatusCountResponse;

  @override
  void initState() {
    super.initState();
    _getAllTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isRequireRefresh){
      _getAllTaskCountByStatus();
      widget.isRequireRefresh=false;
    }
    return SizedBox(
      width: double.infinity,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Visibility(
              visible: !_taskCountByStatusInProgress,
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
                                      taskStatusCountResponse
                                          ?.listOfTaskByStatusData?[index].sum
                                          .toString() ??
                                          ''
                                  }",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(taskStatusCountResponse
                                  ?.listOfTaskByStatusData?[index].sId ?? '',
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
                taskStatusCountResponse?.listOfTaskByStatusData?.length ??
                    0,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getAllTaskCountByStatus() async {
    _taskCountByStatusInProgress = true;
    setState(() {});
    ResponseObject responseObject =
    await NetworkCaller.getRequest(Url.taskStatusCountUrl);
    if (responseObject.isSuccess) {
      taskStatusCountResponse =
          TaskStatusCountResponse.fromJson(responseObject.body);
      _taskCountByStatusInProgress = false;
      setState(() {});
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent: 'Task Count By Status Failed',
            isErrorSnack: true);
        _taskCountByStatusInProgress = false;
        setState(() {});
      }
    }
  }
}
