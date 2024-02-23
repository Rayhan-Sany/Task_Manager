import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/styles/all_widget_style.dart';
import 'package:task_manager/presentation/widgets/theme_data/all_theme_data.dart';
import 'presentation/screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: AllThemeData.inputDecorationTheme(),
        elevatedButtonTheme: AllThemeData.elevatedButtonThemeData(),
        textButtonTheme: AllThemeData.textButtonThemeData(),
        textTheme: AllThemeData.textTheme(context),
      ),
      home: SplashScreen(),
    );
  }
}
