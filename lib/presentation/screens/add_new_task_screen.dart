import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();

  final TextEditingController _descriptionTEController =
      TextEditingController();

  bool _createNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppDefaultAppBar.appBar(),
        body: SvgBackgroundSetter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text('Add New Task',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _subjectTEController,
                  enabled: true,
                  decoration: const InputDecoration(hintText: 'Subject'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionTEController,
                  enabled: true,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  maxLines: 10,
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: !_createNewTaskInProgress,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                      onPressed: () {
                        _createNewTask();
                      },
                      child: const Icon(Symbols.expand_circle_right)),
                )
              ],
            ),
          ),
        ));
  }

  void _createNewTask() async {
    _createNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "title": _subjectTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };
    ResponseObject responseObject =
        await NetworkCaller.postRequest(Url.createTaskUrl, inputParams);
    if (responseObject.isSuccess) {
      _descriptionTEController.clear();
      _subjectTEController.clear();
      if (mounted) {
        commonSnackBar(
            context: context, snackBarContent: 'Task Created Successfully');
        Navigator.pop(context,true);
      }
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent:
                responseObject.errorMassage ?? 'Add New Task Failed',
            isErrorSnack: true);
      }
    }
    _createNewTaskInProgress = false;
    setState(() {});
  }
}
