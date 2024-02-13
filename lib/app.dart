import 'package:flutter/material.dart';
import 'presentation/screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
