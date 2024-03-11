import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/theme_data/all_theme_data.dart';
import 'presentation/screens/splash_screen.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});
   static final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey:TaskManager.globalKey,
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: AllThemeData.inputDecorationTheme,
        elevatedButtonTheme: AllThemeData.elevatedButtonThemeData,
        textButtonTheme: AllThemeData.textButtonThemeData,
        textTheme: AllThemeData.textTheme(context),
        appBarTheme: AllThemeData.appBarTheme(context),
        bottomNavigationBarTheme:AllThemeData.bottomNavigationBarThemeData(context),
        progressIndicatorTheme:AllThemeData.progressIndicatorThemeData,
      ),
      home: const SplashScreen(),
    );
  }
}
