import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap;

  const PieChartWidget({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      chartRadius: MediaQuery.of(context).size.width / 1.6,
      initialAngleInDegree: 0,
      ringStrokeWidth: 32,
      // centerText: "睡眠階段",
      legendOptions: const LegendOptions(legendPosition: LegendPosition.right),
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesInPercentage: true,
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
