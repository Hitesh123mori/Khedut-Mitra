import 'package:flutter/material.dart';

class PricePrediction extends StatefulWidget {
  const PricePrediction({super.key});

  @override
  State<PricePrediction> createState() => _PricePredictionState();
}

class _PricePredictionState extends State<PricePrediction> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("THIS IS PRICE PREDICTION SCREEN"),
        ),
      ),

    );
  }
}
