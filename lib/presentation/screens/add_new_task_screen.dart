import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController subjectTEController = TextEditingController();
    TextEditingController descriptionTEController = TextEditingController();
    return Scaffold(
      appBar:AppDefaultAppBar.appBar(),
      body: SvgBackgroundSetter(
        child: SingleChildScrollView(
          padding:const EdgeInsets.symmetric(horizontal:30,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text('Add New Task',style:Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextFormField(
                controller: subjectTEController,
                enabled: true,
                decoration:const InputDecoration(
                  hintText: 'Subject'
                ),
              ),
              const SizedBox(height:10),
              TextFormField(
                controller: descriptionTEController,
                enabled:true,
                decoration:const InputDecoration(
                  hintText: 'Description',
                ),
                maxLines: 10,
              ),
              const SizedBox(height:20),
              ElevatedButton(onPressed: (){}, child:const Icon(Symbols.expand_circle_right))

            ],
          ),
        ),
      )
    );
  }
}
