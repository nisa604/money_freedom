import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AnalystPage extends StatelessWidget {
  AnalystPage({super.key});
  final dataMap = <String, double>{'China': 11, 'Russia': 9, 'Germany': 10};

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.limeAccent,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 40,
              margin: const EdgeInsets.only(
                bottom: 10,
                top: 10,
                left: 10,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5))),
                      backgroundColor: Colors.grey.shade300,
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.47
                          , 40
                      ),
                    ),
                    child: const Text(
                      "Pengeluaran",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.blue.shade500,
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.47,
                          40)
                      ,
                    ),
                    child: const Text(
                      "Pemasukan",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width:  MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.71,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.disc,
                    baseChartColor: Colors.black54.withOpacity(0.1),
                    colorList: colorList,
                    legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.bottom,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                    totalValue: 100,
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}

