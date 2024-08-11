import 'package:flutter/material.dart';
import 'package:hack_24/screens/utils/color.dart';

class DiseaseIdentified extends StatefulWidget {
  const DiseaseIdentified({super.key});

  @override
  State<DiseaseIdentified> createState() => _DiseaseIdentifiedState();
}

class _DiseaseIdentifiedState extends State<DiseaseIdentified> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.theme['primaryColor'],
          title: Text(
            "Disease Identfied",
            style: TextStyle(
                fontSize: 20, color: AppColors.theme['secondaryColor']),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/downy_mildew.jpg",
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Predicted Disease : Downy Mildew",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    fontSize: 20, color: AppColors.theme['fontColor']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
