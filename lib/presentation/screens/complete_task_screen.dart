import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../controllers/task_list_controller.dart';
import '../widgets/common_screen_widgets/task_card_list.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool isRequireRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDefaultAppBar.appBar(),
      body: SvgBackgroundSetter(
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(),
          child: const Column(
            children: [
              Expanded(
                child: TaskCardList(
                    status: 'Completed'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    Get.find<TaskListController>().getTaskListByStatus('Completed');
  }
}
