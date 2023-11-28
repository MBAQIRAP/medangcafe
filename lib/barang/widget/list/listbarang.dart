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
  Getbarang b = Get.put(Getbarang());
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
          Row(
            children: [
              Obx(() => Text(
                '${b.filter.value}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              )),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  Get.bottomSheet(Filte());
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          )
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
          GetBuilder(
            init: Getbarang() ,
            builder: (val) {
              if(val.filter.value == "Minuman") {
                return Column(
                  children: [
                    for (var a in val.minuman)
                      Expa(
                        kode: a['data']['bar'],
                        id: a['id'],
                        nama: a['data']['nama'],
                        harga: a['data']['harga'],
                        stock: a['data']['jumlah'],
                        kategori: a['data']['kategori'],
                      ),
                  ],
                );
              }else if(val.filter.value == "Makanan"){
              return Column(
                children: [
                  for (var a in val.makanan)
                    Expa(
                      kode: a['data']['bar'],
                      id: a['id'],
                      nama: a['data']['nama'],
                      harga: a['data']['harga'],
                      stock: a['data']['jumlah'],
                      kategori: a['data']['kategori'],
                    ),
                ],
              );
              }else{
                return Column(
                  children: [
                    for (var a in val.barang)
                      Expa(
                        kode: a['data']['bar'],
                        id: a['id'],
                        nama: a['data']['nama'],
                        harga: a['data']['harga'],
                        stock: a['data']['jumlah'],
                        kategori: a['data']['kategori'],
                      ),
                  ],
                );
              }
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
