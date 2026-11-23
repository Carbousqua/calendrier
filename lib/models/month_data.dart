import 'package:flutter/material.dart';

class MonthData {
  final String name;
  final String shortName;
  final String asset;

  const MonthData({
    required this.name,
    required this.shortName,
    required this.asset,
  });
}

const List<MonthData> calendarMonths = [
  MonthData(name: 'Janvier', shortName: 'JAN', asset: 'assets/pages/Janvier.jpg'),
  MonthData(name: 'Février', shortName: 'FÉV', asset: 'assets/pages/Fevrier.jpg'),
  MonthData(name: 'Mars', shortName: 'MAR', asset: 'assets/pages/Mars.jpg'),
  MonthData(name: 'Avril', shortName: 'AVR', asset: 'assets/pages/Avril.jpg'),
  MonthData(name: 'Mai', shortName: 'MAI', asset: 'assets/pages/Mai.jpg'),
  MonthData(name: 'Juin', shortName: 'JUIN', asset: 'assets/pages/Juin.jpg'),
  MonthData(name: 'Juillet', shortName: 'JUIL', asset: 'assets/pages/Juillet.jpg'),
  MonthData(name: 'Août', shortName: 'AOÛ', asset: 'assets/pages/aout.jpg'),
  MonthData(name: 'Septembre', shortName: 'SEP', asset: 'assets/pages/Septembre.jpg'),
  MonthData(name: 'Octobre', shortName: 'OCT', asset: 'assets/pages/Octobre.jpg'),
  MonthData(name: 'Novembre', shortName: 'NOV', asset: 'assets/pages/Novembre.jpg'),
  MonthData(name: 'Décembre', shortName: 'DÉC', asset: 'assets/pages/Decembre.jpg'),
];

ImageProvider getMonthImage(MonthData m) =>
    ResizeImage(AssetImage(m.asset), width: 1000);
