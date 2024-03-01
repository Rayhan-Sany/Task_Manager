import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../widgets/new_task_screen_widgets/task_card_list.dart';
import '../widgets/new_task_screen_widgets/task_counter_section.dart';

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
      body:SvgBackgroundSetter(
        child: Column(
          children: [
            taskCounterSection,
            Expanded(
              child: taskCardList('Cancelled'),
            ),
          ],
        ),
      ),
    );
  }

}
