import 'package:flutter/material.dart';
import 'package:hack_24/screens/utils/color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PricePrediction extends StatefulWidget {
  const PricePrediction({Key? key}) : super(key: key);

  @override
  State<PricePrediction> createState() => _PricePredictionState();
}

class _PricePredictionState extends State<PricePrediction> {
  final Map<String, List<List<dynamic>>> cropPriceData = {
    'Jowar': [
      ['Apr 24', 3314.0],
      ['May 24', 3000.0],
      ['Jun 24', 2800.0],
      ['Jul 24', 2900.0],
      ['Aug 24', 3000.0],
      ['Sep 24', 3100.0],
      ['Oct 24', 3400.0],
      ['Nov 24', 3500.0],
      ['Dec 24', 3100.0],
      ['Jan 25', 2800.0],
      ['Feb 25', 2900.0],
      ['Mar 25', 3000.0],
    ],
    'Rice': [
      ['Apr 24', 3400.0],
      ['May 24', 3500.0],
      ['Jun 24', 2900.0],
      ['Jul 24', 2800.0],
      ['Aug 24', 3000.0],
      ['Sep 24', 2500.0],
      ['Oct 24', 2600.0],
      ['Nov 24', 3000.0],
      ['Dec 24', 3100.0],
      ['Jan 25', 3100.0],
      ['Feb 25', 2600.0],
      ['Mar 25', 3000.0],
    ],
    'Ragi': [
      ['Apr 24', 3211.0],
      ['May 24', 3211.0],
      ['Jun 24', 3212.0],
      ['Jul 24', 3244.0],
      ['Aug 24', 1400.0],
      ['Sep 24', 3000.0],
      ['Oct 24', 1440.0],
      ['Nov 24', 3200.0],
      ['Dec 24', 2900.0],
      ['Jan 25', 1500.0],
      ['Feb 25', 3000.0],
      ['Mar 25', 3212.0],
    ],
    'Sugarcane': [
      ['Apr 24', 3200.0],
      ['May 24', 3200.0],
      ['Jun 24', 3000.0],
      ['Jul 24', 3020.0],
      ['Aug 24', 3100.0],
      ['Sep 24', 3100.0],
      ['Oct 24', 2940.0],
      ['Nov 24', 3200.0],
      ['Dec 24', 2880.0],
      ['Jan 25', 3000.0],
      ['Feb 25', 3220.0],
      ['Mar 25', 3200.0],
    ],
  };

  String getCurrentMonth() {
    return DateFormat('MMM yy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    String currentMonth = getCurrentMonth();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: cropPriceData.entries.map((entry) {
            String crop = entry.key;
            List<List<dynamic>> prices = entry.value;
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crop,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 300,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(text: 'Price'),
                      ),
                      series: <LineSeries<List<dynamic>, String>>[
                        LineSeries<List<dynamic>, String>(
                          dataSource: prices,
                          xValueMapper: (data, _) => data[0] as String,
                          yValueMapper: (data, _) => data[1] as double,
                          color: AppColors.theme['primaryColor'],
                          width: 2,
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            color: AppColors.theme['secondaryColor'],
                            shape: DataMarkerType.circle,
                          ),
                        ),
                      ],

                      annotations: <CartesianChartAnnotation>[
                        CartesianChartAnnotation(
                          widget: Container(
                            color: AppColors.theme['primaryColor'].withOpacity(0.2),
                            child: Text(
                              'Current Month: $currentMonth',
                              style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize: 12),
                            ),
                            padding: EdgeInsets.all(8),
                          ),
                          coordinateUnit: CoordinateUnit.point,
                          x: currentMonth,
                          y: prices.firstWhere(
                                (p) => p[0] == currentMonth,
                            orElse: () => ['Unknown', 0.0],
                          )[1] as double,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
