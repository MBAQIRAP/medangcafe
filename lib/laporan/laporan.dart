import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/transaksicontroller.dart';
import '../manage/formater.dart';

class Laporan extends StatefulWidget {
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
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
              builder: (val) {
                int b = 0;
                val.transaksi.forEach((item) {
                  b += int.parse(item['data']['bayar'].toString());
                });
                return Text(uang.format(b));
              },
        )));
  }
}
