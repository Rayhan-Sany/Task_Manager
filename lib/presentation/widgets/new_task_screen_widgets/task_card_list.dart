import 'package:flutter/material.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/models/task_by_status_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/new_task_screen_widgets/task_card.dart';

class TaskCardList extends StatefulWidget {
  final String status;
   bool isRequireRefresh;
   TaskCardList({super.key, required this.status,required this.isRequireRefresh});

  @override
  State<TaskCardList> createState() => _TaskCardListState();
}

class _TaskCardListState extends State<TaskCardList> {
  bool getTaskByStatusInProgress = false;
  bool deleteTaskInProgress = false;
  TaskCardResponseByStatus? taskCardResponseByStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskByStatusDataFormApis();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isRequireRefresh){
      _getTaskByStatusDataFormApis();
      widget.isRequireRefresh=false;
    }
    return Visibility(
      visible: getTaskByStatusInProgress == false&&deleteTaskInProgress==false,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: Visibility(
        visible:taskCardResponseByStatus?.taskByStatusDataList?.isNotEmpty??false,
        replacement: const Center(
          child:Text('No Task Added',style:TextStyle(fontSize: 20)),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) => TaskCard(
            taskByStatusData:
                taskCardResponseByStatus!.taskByStatusDataList![index],
            deleteTaskLocally: () {
              deleteTaskFromListLocally(index);
            },
          ),
          shrinkWrap: true,
          itemCount:
              taskCardResponseByStatus?.taskByStatusDataList?.length ?? 0,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
      ),
    );
  }

  void deleteTaskFromListLocally(int index) {
    deleteTaskInProgress = true;
    setState(() {});
    taskCardResponseByStatus?.taskByStatusDataList?.removeAt(index);
    deleteTaskInProgress=false;
    setState(() {});
  }

  Future<void> _getTaskByStatusDataFormApis() async {
    getTaskByStatusInProgress = true;
    setState(() {});
    ResponseObject responseObject = await NetworkCaller.getRequest(
        Url.taskCardDataByStatusUrl(widget.status));
    if (responseObject.isSuccess) {
      getTaskByStatusInProgress = false;
      setState(() {});
      taskCardResponseByStatus =
          TaskCardResponseByStatus.fromJson(responseObject.body);
    } else {
      getTaskByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent: responseObject.errorMassage ??
                'Get Task Card List Has been failed');
      }
    }
  }
}
