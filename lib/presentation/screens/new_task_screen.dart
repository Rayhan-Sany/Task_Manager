import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/task_count_controller.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utils/app_color.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../controllers/task_list_controller.dart';
import '../widgets/common_screen_widgets/task_card_list.dart';
import '../widgets/common_screen_widgets/task_counter_section.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.baseColor,
        foregroundColor: Colors.white,
        onPressed: () async {
          bool isNewTaskAdded =await Get.to(const AddNewTaskScreen());
          if(isNewTaskAdded){
            _refreshWidgets();
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppDefaultAppBar.appBar(),
      body: SvgBackgroundSetter(
        child: RefreshIndicator(
          onRefresh: () {
            return _refreshWidgets();
          },
          child: const Column(
            children: [
              TaskCounterSection(),
              Expanded(
                child: TaskCardList(
                  status: 'New',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshWidgets() async {
    Get.find<TaskListController>().getTaskListByStatus('New');
    Get.find<TaskCountController>().getTaskCountByStatus();
  }

}
