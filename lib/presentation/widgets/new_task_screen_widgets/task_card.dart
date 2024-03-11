import 'package:flutter/material.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/models/taskByStatusData.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';

class TaskCard extends StatefulWidget {
  final TaskByStatusData taskByStatusData;
  final VoidCallback deleteTaskLocally;

  const TaskCard(
      {super.key,
      required this.taskByStatusData,
      required this.deleteTaskLocally});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool taskDeleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: taskDeleteInProgress == false,
        replacement: const Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator())),
        child: taskCard());
  }

  Card taskCard() {
    return Card(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.taskByStatusData.title ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              Text(
                widget.taskByStatusData.description ?? '',
                style: const TextStyle(fontSize: 13),
              ),
              Text(
                'Date : ${widget.taskByStatusData.createdDate}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Chip(
                    label: Text(widget.taskByStatusData.status ?? ''),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        _showUpdateStatusDialog();
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        _showAlertDialog();
                      },
                      icon: const Icon(Icons.delete_outline)),
                ],
              ),
            ],
          ),
        ));
  }

  _showUpdateStatusDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Select Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      title: const Text('New'),
                      trailing: widget.taskByStatusData.status == 'New'
                          ? const Icon(Icons.check)
                          : const Spacer(),
                      onTap:() {_updateTaskStatusById('New');Navigator.pop(context);}),
                  ListTile(
                      title: const Text('Progress'),
                      trailing: widget.taskByStatusData.status == 'Progress'
                          ? const Icon(Icons.check)
                          : const Spacer(),
                      onTap:() {_updateTaskStatusById('Progress');Navigator.pop(context);}),
                  ListTile(
                      title: const Text('Completed'),
                      trailing: widget.taskByStatusData.status == 'Completed'
                          ? const Icon(Icons.check)
                          : const Spacer(),
                      onTap:() {_updateTaskStatusById('Completed');Navigator.pop(context);}),
                  ListTile(
                      title: const Text('Cancelled'),
                      trailing: widget.taskByStatusData.status == 'Cancelled'
                          ? const Icon(Icons.check)
                          : const Spacer(),
                      onTap:() {_updateTaskStatusById('Cancelled');Navigator.pop(context);}),
                ],
              ),
            ));
  }

  Future<void> _updateTaskStatusById(String status) async {
    ResponseObject responseObject = await NetworkCaller.getRequest(
        Url.updateTaskStatusUrl(widget.taskByStatusData.sId ?? '',status));
    if (responseObject.isSuccess) {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent: 'Task Status Update Successfully');
      }
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent:
                responseObject.errorMassage ?? "Task Status update Failed");
      }
    }
  }

  Future _showAlertDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are You Want To Delete Task??'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteTask(widget.taskByStatusData.sId!);
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }

  void deleteTask(String taskId) async {
    taskDeleteInProgress = true;
    ResponseObject responseObject = await NetworkCaller.getRequest(
        Url.deleteTaskUrl(widget.taskByStatusData.sId!));
    if (responseObject.isSuccess) {
      if (mounted) {
        commonSnackBar(
            context: context, snackBarContent: 'Task Deleted Successfully');
        widget.deleteTaskLocally();
        taskDeleteInProgress = false;
        setState(() {});
      } else {
        if (mounted) {
          taskDeleteInProgress = false;
          setState(() {});
          commonSnackBar(
              context: context,
              snackBarContent:
                  responseObject.errorMassage ?? 'Task Delete Failed');
        }
      }
    }
  }
}
