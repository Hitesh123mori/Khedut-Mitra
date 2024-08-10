import 'package:flutter/material.dart';
import 'package:hack_24/apis/gen_api.dart';

import '../../../apis/helper_api/season_identification.dart';

class PricePrediction extends StatefulWidget {
  const PricePrediction({super.key});

  @override
  State<PricePrediction> createState() => _PricePredictionState();
}

class _PricePredictionState extends State<PricePrediction> {

  List<String>? crops = SeasonIdntification.seasonPlants[SeasonIdntification.getCurrentPlantSeason()];

  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [

            ElevatedButton(onPressed: ()async{
              await ApiService.fetchAlbum(crops![0]) ;
            }, child: Text("dfg")),

          ],
        )
      ),

    );
  }
}
