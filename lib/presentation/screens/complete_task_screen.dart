import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
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
          child: Column(
            children: [
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
