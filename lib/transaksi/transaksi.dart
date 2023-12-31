import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medang_caffe/transaksi/widget/listsearch.dart';
import 'package:medang_caffe/transaksi/widget/search.dart';
import 'package:medang_caffe/transaksi/history.dart';

import '../controller/menucontroller.dart';
import '../controller/transaksicontroller.dart';
import '../manage/formater.dart';

class Transaksi extends StatefulWidget {
  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  TransaksiController t = Get.put(TransaksiController());
  Getmenu b = Get.put(Getmenu());
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
          "Medang Cafe",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(
                History(),
              );
            },
            child: Icon(Icons.history, color: Colors.black),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: GetBuilder<Getmenu>(
        init: Getmenu(),
        builder: (val) {
          final a = val.beli;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: val.beli.length < 0 || val.beli.isEmpty || val.beli == null
                ? SizedBox(
                    height: Get.height / 1.5,
                    child: Center(
                      child:
                          Lottie.asset('assets/kopi.json', width: Get.width / 2),
                    ),
                  )
                : Column(
                    children: [
                      for (var i = 0; i < val.beli.length; i++)
                        ListSearch(
                          kode: a[i]['kode'],
                          id: a[i]['id'],
                          nama: a[i]['nama'],
                          harga: a[i]['harga'],
                          stock: a[i]['jumlah'],
                          x: true,
                          i: i,
                          jumbel: a[i]['jumlahbeli'],
                        ),
                    ],
                  ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
          child : GetBuilder<Getmenu>(
            init: Getmenu(),
            builder: (val) {
              int b = 0;
              val.beli.forEach((item) {
                b += int.parse(item['totharga'].toString());
              });
              return val.beli.isNotEmpty || val.beli.length > 0
                  ? InkWell(
                      onTap: () {
                        if (val.beli == null ||
                            val.beli.length <= 0 ||
                            b == null ||
                            b == 0) {
                          print("Kosong");
                        } else {
                          t.addtransaksi(data: val.beli, bayar: b);
                          val.stockEdit();
                          val.hapusbeliall();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        height: 40,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: Text(
                            uang.format(b),
                            style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                   : SizedBox(
                      width: 40,
                    );
            },
          ),
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.black,
            onPressed: () {
              Get.to(
                Search(),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
