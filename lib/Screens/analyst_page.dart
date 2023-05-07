/**
 * @Author: Your name
 * @Date:   2023-04-04 11:24:59
 * @Last Modified by:   Your name
 * @Last Modified time: 2023-05-07 20:09:10
 */
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AnalystPage extends StatelessWidget {
  // const AnalystPage({super.key});

  final dataMap = <String, double>{
    "Flutter": 20,
    "React Native": 20,
    "Xamarin": 20,
    "Ionic": 20,
  };

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.cyanAccent,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: SizedBox(
                height: 13,
                // // width: 100,
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: PieChart(
                  dataMap: dataMap,
                  chartType: ChartType.disc,
                  baseChartColor: Colors.grey[100]!.withOpacity(0.5),
                  colorList: colorList,
                  chartValuesOptions: ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                  totalValue: 100,
                ),
              ),
            ),
          ),
          Column(
<<<<<<< HEAD
            children: [Container()],
=======
            children: <Widget>[
              // Text('Column Child 1'),
              // Text('Column Child 2'),
            ],
>>>>>>> c9e552e705ad404072176e965466a2d7ca26522b
          ),
        ],
      ),
    );
  }
}
