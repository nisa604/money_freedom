import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AnalystPage extends StatelessWidget {
  // const AnalystPage({super.key});
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
        Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              // padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 192, 192, 192),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(width: 15),
                      Container(
                          margin: EdgeInsets.zero,
                          child: TextButton(
                            onPressed: () {
                              // Handle button press
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors
                                  .blue, // Set the button's background color
                            ),
                            child: const Text('Pemasukan'),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Pengeluaran"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
        Card(
          elevation: 10,
          child: Container(
            // width: MediaQuery.of(context).size.width *
            //     0.2, // Atur lebar sesuai kebutuhan
            width: 800,
            height: 550, // Atur tinggi sesuai kebutuhan
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                padding: const EdgeInsets.all(16),
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
          ),
        )
      ],
    ));
  }
}
