import 'package:flutter/material.dart' ;
import 'package:hack_24/constants/disease_identification.dart';
import 'package:hack_24/screens/transition/left_right.dart';

import '../../home_screens/disease_identified_screen.dart';
import '../color.dart';

class Dcard extends StatefulWidget {
  final DImage di ;

  const Dcard({super.key, required this.di});

  @override
  State<Dcard> createState() => _DcardState();
}

class _DcardState extends State<Dcard> {



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, LeftToRight(DiseaseIdentified())) ;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.theme['primaryColor'].withOpacity(0.1)
          ),
          child: Row(
            children: [
              SizedBox(width: 20,),
              Image.asset(widget.di.path,height: 100,width: 100,),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(widget.di.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text(widget.di.Dname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)




                    ],

                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
