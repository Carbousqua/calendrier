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
  MonthData(name: 'Janvier', shortName: 'JAN', asset: 'assets/pages/Janvier.png'),
  MonthData(name: 'Février', shortName: 'FÉV', asset: 'assets/pages/Fevrier.png'),
  MonthData(name: 'Mars', shortName: 'MAR', asset: 'assets/pages/Mars.png'),
  MonthData(name: 'Avril', shortName: 'AVR', asset: 'assets/pages/Avril.png'),
  MonthData(name: 'Mai', shortName: 'MAI', asset: 'assets/pages/Mai.png'),
  MonthData(name: 'Juin', shortName: 'JUIN', asset: 'assets/pages/Juin.png'),
  MonthData(name: 'Juillet', shortName: 'JUIL', asset: 'assets/pages/Juillet.png'),
  MonthData(name: 'Août', shortName: 'AOÛ', asset: 'assets/pages/aout.png'),
  MonthData(name: 'Septembre', shortName: 'SEP', asset: 'assets/pages/Septembre.png'),
  MonthData(name: 'Octobre', shortName: 'OCT', asset: 'assets/pages/Octobre.png'),
  MonthData(name: 'Novembre', shortName: 'NOV', asset: 'assets/pages/Novembre.png'),
  MonthData(name: 'Décembre', shortName: 'DÉC', asset: 'assets/pages/Decembre.png'),
];

ImageProvider getMonthImage(MonthData m) =>
    ResizeImage(AssetImage(m.asset), width: 1000);
