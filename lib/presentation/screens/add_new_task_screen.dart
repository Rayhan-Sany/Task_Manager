import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async{
        Get.back(result:false);
        return ;
      },
      child: Scaffold(
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
                  GetBuilder<AddNewTaskController>(
                    builder: (addNewTaskController) {
                      return Visibility(
                        visible:addNewTaskController.isAddTaskInInProgress==false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              _createNewTask();
                            },
                            child: const Icon(Symbols.expand_circle_right)),
                      );
                    }
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _createNewTask() async {
    FocusScope.of(context).unfocus();
   final result = await Get.find<AddNewTaskController>().addNewTask(
        _subjectTEController.text.trim(), _descriptionTEController.text.trim());
    if (result) {
      _descriptionTEController.clear();
      _subjectTEController.clear();
      if (mounted) {
        commonSnackBar(
            context: context, snackBarContent: 'Task Created Successfully');
         Get.back(result:true);
      }
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent:
            Get.find<AddNewTaskController>().getErrorMessage ,
            isErrorSnack: true);
      }
    }

  }
}
