import 'package:flutter/material.dart';

Card  taskCard({required String chipLabelText}) {
  return Card(
      color: Colors.white,
      child:Padding(
        padding: const EdgeInsets.only(left:10,right:10,top:10,bottom:5),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text('Here Title will be shown',style:TextStyle(fontSize:18,fontWeight: FontWeight.w800)),
            Text('Description will be shown here',style:TextStyle(fontSize:13),),
            Text('Date : 12-10-2024',style: TextStyle(fontWeight: FontWeight.bold),),
            Row(
              children: [
                Chip(label:Text(chipLabelText),
                  padding: EdgeInsets.zero,

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20,vertical:0),


                ),
                const Spacer(),
                IconButton(onPressed:(){}, icon:const Icon(Icons.edit)),
                IconButton(onPressed:(){}, icon:const Icon(Icons.delete_outline)),
              ],
            ),

          ],
        ),
      )
  );
}