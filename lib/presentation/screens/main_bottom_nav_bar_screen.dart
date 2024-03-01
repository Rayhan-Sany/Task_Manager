import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/cancelled_task_screen.dart';
import 'package:task_manager/presentation/screens/new_task_screen.dart';
import 'package:task_manager/presentation/screens/progress_task_screen.dart';

import 'complete_task_screen.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
   int _currentIndex=0;
  final List<Widget> _screens =const[
    NewTaskScreen(),
    CompleteTaskScreen(),
    ProgressTaskScreen(),
    CancelledTaskScreen(),
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_currentIndex,
        onTap: (index) {
          _currentIndex = index;
         if(mounted){ setState(() {});}
        },

        items: const[
          BottomNavigationBarItem(icon:Icon(Icons.create),label:'New'),
          BottomNavigationBarItem(icon:Icon(Icons.done_all),label:'Completed'),
          BottomNavigationBarItem(icon:Icon(Icons.run_circle_outlined),label: 'Progress'),
          BottomNavigationBarItem(icon:Icon(Icons.delete_outline),label:'Cancelled'),
        ],
      ),
      body:_screens[_currentIndex],
    );
  }
}
