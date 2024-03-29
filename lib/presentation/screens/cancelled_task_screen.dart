import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../controllers/task_list_controller.dart';
import '../widgets/common_screen_widgets/task_card_list.dart';
class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppDefaultAppBar.appBar(),
      body: SvgBackgroundSetter(
        child: RefreshIndicator(
          onRefresh:()=>_onRefresh(),
          child: const Column(
            children: [
              Expanded(
                child: TaskCardList(status:'Cancelled'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _onRefresh() async {
       Get.find<TaskListController>().getTaskListByStatus('Cancelled');
  }
}
