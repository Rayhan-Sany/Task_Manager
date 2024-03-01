import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/new_task_screen_widgets/task_card.dart';
ListView taskCardList(String chipLabelText) {
  return ListView.builder(itemBuilder: (context,index)=>taskCard(chipLabelText:chipLabelText),
    shrinkWrap:true,
    itemCount: 6,
    scrollDirection:Axis.vertical,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),

  );
}