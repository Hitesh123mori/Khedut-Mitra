import 'package:flutter/material.dart' ;


class SeasonIdntification{


  static String getCurrentPlantSeason() {
    DateTime now = DateTime.now();
    int month = now.month;

    if (month == 12 || month == 1 || month == 2) {
      return 'Winter';
    } else if (month >= 3 && month <= 5) {
      return 'Spring';
    } else if (month >= 6 && month <= 8) {
      return 'Summer';
    } else if (month >= 9 && month <= 11) {
      return 'Monsoon';
    } else {
      return 'Unknown Season';
    }
  }

}