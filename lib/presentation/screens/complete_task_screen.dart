import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../widgets/new_task_screen_widgets/task_card_list.dart';
import '../widgets/new_task_screen_widgets/task_counter_section.dart';

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
          child: Column(
            children: [
              TaskCounterSection(isRequireRefresh: isRequireRefresh),
              Expanded(
                child: TaskCardList(
                    status: 'Completed', isRequireRefresh: isRequireRefresh),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    isRequireRefresh = true;
    setState(() {});
  }
}
