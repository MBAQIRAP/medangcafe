import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CircleChart extends StatefulWidget{
  @override
  _CircleChartState createState() => _CircleChartState();
}

class _CircleChartState extends State<CircleChart> {
  @override
  Widget build(BuildContext context){
    return PieChart(
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 2,
            title: "Tahu",
          ),
          PieChartSectionData(
            value: 3,
            title: "Teh",
          ),
        ]
      ),
    );
  }
}