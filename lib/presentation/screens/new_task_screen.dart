import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utils/app_color.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../widgets/common_screen_widgets/task_card_list.dart';
import '../widgets/common_screen_widgets/task_counter_section.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool isNewTaskAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.baseColor,
        foregroundColor: Colors.white,
        onPressed: () async {
          isNewTaskAdded = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppDefaultAppBar.appBar(),
      body: SvgBackgroundSetter(
        child: RefreshIndicator(
          onRefresh: () {
            return _refreshWidgets();
          },
          child: Column(
            children: [
              TaskCounterSection(
                isRequireRefresh: isNewTaskAdded,
              ),
              Expanded(
                child: TaskCardList(
                  status: 'New',
                  isRequireRefresh: isNewTaskAdded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshWidgets() async {
    isNewTaskAdded = true;
    setState(() {});
  }
}
