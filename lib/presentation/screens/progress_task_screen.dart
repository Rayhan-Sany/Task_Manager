import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../widgets/common_screen_widgets/task_card_list.dart';
import '../widgets/common_screen_widgets/task_counter_section.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool isRequireRefresh=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppDefaultAppBar.appBar(),
      body: SvgBackgroundSetter(
        child: RefreshIndicator(
          onRefresh:()=>_onRefresh(),
          child: Column(
            children: [
              TaskCounterSection(isRequireRefresh:isRequireRefresh),
              Expanded(
                child: TaskCardList(status:'Progress',isRequireRefresh:isRequireRefresh),
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
