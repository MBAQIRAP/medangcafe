import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../controller/menucontroller.dart';
import '../controller/transaksicontroller.dart';
import '../manage/formater.dart';

class Laporan extends StatefulWidget {
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  Getmenu b = Get.put(Getmenu());
  List<Color> randomColors = [];
  List reverse=[];
  TransaksiController t = Get.put(TransaksiController());

  @override
  void initState() {
    getSections();
    super.initState();
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = reverse[0]['tgl'] ?? '';
        break;
      case 1:
        text = reverse[1]['tgl'] ?? '';
        break;
      case 2:
        text = reverse[2]['tgl'] ?? '';
        break;
      case 3:
        text = reverse[3]['tgl'] ?? '';
        break;
      case 4:
        text = reverse[4]['tgl'] ?? '';
        break;
      case 5:
        text = reverse[5]['tgl'] ?? '';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  void getSections() {
    Random random = Random();
    randomColors = List.generate(t.transmakanan.length, (index) {
      Color generatedColor;

      do {
        generatedColor = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1.0,
        );
      } while (isColorTooDark(generatedColor));

      return generatedColor;
    });
  }

  bool isColorTooDark(Color color) {
    // Adjust this threshold to your preference
    final darknessThreshold = 0.5;

    // Calculate color darkness using a simple formula
    double darkness =
        1 - (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    return darkness < darknessThreshold;
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Text(
              "Laporan",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: GetBuilder<TransaksiController>(
                init: TransaksiController(),
                builder: (transaksiController) {
                  reverse = List.from(t.transaksichart.reversed);
                  int b = 0;
                  transaksiController.transaksi.forEach((item) {
                    b += int.parse(item['data']['bayar'].toString());
                  });
                  return GetBuilder(
                    init: Getmenu(),
                    builder: (menuController) {
                      int count = 0;
                      menuController.menu.forEach((item) {
                        count += int.parse(item['data']['jumlah'].toString());
                      });
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Harga Transaksi Cafe",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  uang.format(b),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      color: Colors.black,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black87,
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Jenis Menu",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          menuController.menu.length
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      color: Colors.black,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black87,
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Jumlah Stok",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          count.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      color: Colors.black,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black87,
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Jumlah Transaksi",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          transaksiController.transaksi.length
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: 350,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 5,
                                            color: Colors.black.withOpacity(
                                                0.3),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              heightFactor: 1.3,
                                              child: Text("Transaksi Menu",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              height: 200,
                                              width: 200,
                                              child: PieChart(
                                                PieChartData(
                                                  sectionsSpace: 0,
                                                  centerSpaceRadius: 0,
                                                  sections: List.generate(
                                                    transaksiController
                                                        .transmakanan.length,
                                                        (index) {
                                                      return PieChartSectionData(
                                                        radius: 100,
                                                        badgePositionPercentageOffset: 10,
                                                        titlePositionPercentageOffset: 0.75,
                                                        value: double.parse(
                                                            transaksiController
                                                                .transmakanan[index]['jumlahbeli']
                                                                .toString()),
                                                        title: transaksiController
                                                            .transmakanan[index]['nama'] + "\n" + transaksiController
                                                            .transmakanan[index]['jumlahbeli'].toString(),
                                                        color: randomColors[index],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                            ],
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: 350,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.3),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      heightFactor: 1.3,
                                      child: Text("Jumlah Transaksi Chart",
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),),
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    width: 350,
                                    child: BarChart(
                                      BarChartData(
                                        titlesData: FlTitlesData(
                                          topTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            )
                                          ),
                                          rightTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            )
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: getTitles,
                                            )
                                          )
                                        ),
                                        borderData: FlBorderData(
                                          border: Border(
                                            top: BorderSide.none,
                                            bottom: BorderSide(width: 1),
                                            left: BorderSide(width: 1)
                                          )
                                        ),
                                        barGroups:
                                          List.generate(min(5, transaksiController.transaksichart.length),
                                                  (index){
                                                    return BarChartGroupData(
                                                        x: index,
                                                        barRods: [
                                                          BarChartRodData(
                                                            width: 25,
                                                            fromY: 0,
                                                            toY: double.parse(reverse[index]['jumlah'].toString()),
                                                          )
                                                        ]
                                                    );
                                                  })
                                      )
                                    ),
                                  ),
                                ],
                              )
                              ),
                            ),
                          SizedBox(height: 20)
                        ],
                      );
                    },
                  );
                },
              )));
    }
}
