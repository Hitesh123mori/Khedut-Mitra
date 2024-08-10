import 'package:flutter/material.dart' ;


class SeasonIdntification{


  static String getCurrentPlantSeason() {
    DateTime now = DateTime.now();
    int month = now.month;

    if (month == 11 || month == 12 || month == 1 || month == 2) {
      return 'Winter';
    } else if (month >= 3 && month <= 6) {
      return 'Summer';
    } else if (month >= 6 && month <= 10) {
      return 'Monsoon';
    } else {
      return 'Unknown Season';
    }
  }

  static final Map<String, List<String>> seasonPlants = {
    'Winter': [
      'Barley',
      'Rapeseed',
      'Wheat',
      'masoor',
      'moong',
      'urad',
    ],
    'Monsoon': [
      'Jowar',
      'Rice',
      'ragi',
      'jowar',
      'sugarcane',
    ],
    'Summer': [
       'Pumpkin'
      'Cucumber',
      'Bitter Gourd',
    ],
  };


}