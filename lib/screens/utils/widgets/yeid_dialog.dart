import 'package:flutter/material.dart';

import '../color.dart';

class YieldDialog extends StatelessWidget {
  final double predictedYield;
  final double randomYield;

  const YieldDialog({
    required this.predictedYield,
    required this.randomYield,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: AnimatedPadding(
        padding: const EdgeInsets.all(20.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Yield Prediction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${predictedYield.toStringAsFixed(2)} Quintal/Acre',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.theme['fontColor']),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',style: TextStyle(color: AppColors.theme['fontColor']),),
            ),
          ],
        ),
      ),
    );
  }
}
