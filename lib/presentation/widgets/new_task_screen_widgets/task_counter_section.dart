import 'package:flutter/material.dart';

SizedBox get taskCounterSection {
  return SizedBox(
    width:double.infinity,
    height:80 ,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => const Card(
              margin: EdgeInsets.all(8),
              color: Colors.white,
              child:Padding(
                padding: EdgeInsets.symmetric(vertical:0,horizontal:4),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text('09',style:TextStyle(
                        fontSize:24,
                        fontWeight:FontWeight.bold
                    )),
                    Text('New Task')
                  ],
                ),
              ),
            ),
            separatorBuilder: (_,__) =>const SizedBox(width:2,),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        )
      ],
    ),
  );
}