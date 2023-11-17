import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/barangcontroller.dart';
import 'contentlist.dart';
import 'filte.dart';

class ListBarang extends StatefulWidget {
  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  Widget listb() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "List barang",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          listb(),
          SizedBox(
            height: 5,
          ),
          GetBuilder<Getbarang>(
            init: Getbarang(),
            builder: (val) {
              return Column(
                children: [
                  for (var a in val.barang)
                    Expa(
                      kode: a['data']['bar'],
                      id: a['id'],
                      nama: a['data']['nama'],
                      harga: a['data']['harga'],
                      stock: a['data']['jumlah'],
                    ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
