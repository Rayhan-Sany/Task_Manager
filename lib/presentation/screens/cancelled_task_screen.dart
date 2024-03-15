import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

import '../widgets/common_screen_widgets/task_card_list.dart';
import '../widgets/common_screen_widgets/task_counter_section.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
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
                child: TaskCardList(status:'Cancelled',isRequireRefresh:isRequireRefresh),
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
