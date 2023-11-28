import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/barangcontroller.dart';

class TotalUp extends StatefulWidget {
  @override
  _TotalUpState createState() => _TotalUpState();
}

class _TotalUpState extends State<TotalUp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Getbarang>(
      init: Getbarang(),
      builder: (val) {
        int b = 0;
        val.barang.forEach((item) {
          b += int.parse(item['data']['jumlah'].toString());
        });
        return Row(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daftar Makanan",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    val.makanan.length.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daftar Minuman",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    val.minuman.length.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
