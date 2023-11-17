

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Getbarang extends GetxController {
  CollectionReference dbbarang =
      FirebaseFirestore.instance.collection('barang');
  List barang = [];
  List temu = [];
  List beli = [];
  List sortgl = [];

  hapusbeliall() {
    beli.clear();
    update();
  }

  hapusbeli({required int i}) {
    beli.removeAt(i);
    print(beli);
    update();
  }

  addbeli(
      {required String kode,
      required String nama,
      required int harga,
      required int jumlah,
      required String id,
      required int jumlahbeli,
      required int tot}) {
    beli.add({
      'idb': id,
      'kode': kode,
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'jumlahbeli': jumlahbeli,
      'totharga': tot,
    });
    temu.clear();
    Get.back();
    update();
  }

  stockEdit() async {
    beli.forEach((map) async {
      dbbarang.where("nama",isEqualTo: map['nama'].toString()).get().then(
              (querySnapshot) {
                querySnapshot.docs.forEach((element) {
                  Map<String,dynamic> data = element.data() as Map<String, dynamic>;
                  String idDoc = element.id;
                  int jmllama=int.parse(data['jumlah'].toString());
                  int jmlBarang = int.parse(map['jumlahbeli'].toString());
                  int jmlUpdate = jmllama - jmlBarang;
                  dbbarang.doc(idDoc).update({
                    'jumlah' : jmlUpdate
                  });
                });
              }
      );
      update();
    });
    update();
  }

  void cari({required String cari}) async {
    if (cari.isEmpty || !cari.contains(RegExp(r'[a-zA-Z]'))) {
      temu = List.from(barang);
    } else {
      List<String> searchWords = cari.toLowerCase().split(' ');
      temu = barang
          .where((element) =>
          searchWords.any((word) =>
              element['data']['nama']
                  .toString()
                  .toLowerCase()
                  .contains(word)))
          .toList();
      if (temu.isEmpty) {
        temu = [
          {
            'message': 'kosong',
          }
        ];
      }
    }

    // Notify listeners that the state has been updated.
    update();
  }

  Stream<QuerySnapshot> getbarang() {
    barang.clear();
    Stream<QuerySnapshot> stream = dbbarang
        .orderBy('tgl', descending: true)
        .snapshots(includeMetadataChanges: true);

    stream.listen((querySnapshot) {
        barang.clear();
        querySnapshot.docs.forEach((res) {
            barang.add(
              {
                'id': res.id,
                'data': res.data(),
              },
            );
            update();
          },
        );
        update();
      },
    );
    return stream;
  }

  addbarang({required String bar, required String nama, required int harga, required int jumlah}) async {
    await dbbarang.add({
      'bar': bar,
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'tgl': DateTime.now(),
    });
    update();
  }

  editbarang({required String id, required String nama, required int harga, required int stock}) async {
    await dbbarang.doc(id).update({
      'nama': nama,
      'harga': harga,
      'jumlah': stock,
    });
    update();
  }

  deletbarang({required String id, required String nama}) async {
    await dbbarang.doc(id).delete();
    Get.rawSnackbar(
      margin: EdgeInsets.all(15),
      borderRadius: 15,
      backgroundColor: Colors.red,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.elasticOut,
      messageText: Row(
        children: [
          Icon(
            Icons.delete_outline_rounded,
            color: Colors.white,
          ),
          Text(
            "$nama berhasil dihapus",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    update();
  }
}
