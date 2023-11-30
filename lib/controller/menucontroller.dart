import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Getmenu extends GetxController {
  CollectionReference dbmenu = FirebaseFirestore.instance.collection('menu');
  List menu = [];
  List temu = [];
  List beli = [];
  List sortgl = [];
  List makanan = [].obs;
  List minuman = [].obs;

  var filter= "All".obs;

  late var daftarMakanan = makanan.length.obs;

  late var daftarMinuman = minuman.length.obs;

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
      {required String id,
      required String nama,
      required int harga,
      required int jumlah,
      required int jumlahbeli,
        required String kategori,
        required int tot,}) {
    beli.add({
      'id': id,
      'nama': nama,
      'kategori' : kategori,
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
      dbmenu.where("nama",isEqualTo: map['nama'].toString()).get().then(
              (querySnapshot) {
                querySnapshot.docs.forEach((element) {
                  Map<String,dynamic> data = element.data() as Map<String, dynamic>;
                  String idDoc = element.id;
                  int jmllama=int.parse(data['jumlah'].toString());
                  int jmlMenu = int.parse(map['jumlahbeli'].toString());
                  int jmlUpdate = jmllama - jmlMenu;
                  dbmenu.doc(idDoc).update({
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
    String lowerCaseQuery = cari.trim().toLowerCase();
    var filteredList = menu
        .where((element) =>
        element['data']['nama']
            .toString()
            .toLowerCase()
            .startsWith(lowerCaseQuery))
        .toList();

    // Check if the filtered list is empty
    if (filteredList.isEmpty) {
      // If empty, set a message in temu
      temu = [
        {
          'message': 'No results found', // Your message for no results
        }
      ];
    } else {
      // If not empty, set temu to the filtered list
      temu = filteredList;
    }

    // Trigger a rebuild of the widget tree to reflect the updated state
    update();
  }

  Stream<QuerySnapshot> getmenu() {
    menu.clear();
    Stream<QuerySnapshot> stream = dbmenu
        .orderBy('tgl', descending: true)
        .snapshots(includeMetadataChanges: true);

    stream.listen((querySnapshot) {
        menu.clear();
        querySnapshot.docs.forEach((res) {
            menu.add(
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

  Stream<QuerySnapshot> getmakanan() {
    makanan.clear();
    Stream<QuerySnapshot> stream = dbmenu
        .where('kategori', isEqualTo: 'makanan')
        .orderBy('tgl', descending: true)
        .snapshots(includeMetadataChanges: true);

    stream.listen((querySnapshot) {
      makanan.clear();
      querySnapshot.docs.forEach((res) {
        makanan.add(
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

  Stream<QuerySnapshot> getminuman() {
    minuman.clear();
    Stream<QuerySnapshot> stream = dbmenu
        .where('kategori', isEqualTo: 'minuman')
        .orderBy('tgl', descending: true)
        .snapshots(includeMetadataChanges: true);

    stream.listen((querySnapshot) {
      minuman.clear();
      querySnapshot.docs.forEach((res) {
        minuman.add(
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


  addmenu(
      {
        required String nama,
        required int harga,
        required int jumlah,
        required String kategori}) async {
    await dbmenu.add({
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'jumlah': jumlah,
      'tgl': DateTime.now(),
    });
    update();
  }

  editmenu(
      {required String id,
        required String nama,
        required int harga,
        required int stock,
        required String kategori}) async {
    await dbmenu.doc(id).update({
      'nama': nama,
      'harga': harga,
      'kategori' : kategori,
      'jumlah': stock,
    });
    update();
  }

  deletmenu({required String id, required String nama}) async {
    await dbmenu.doc(id).delete();
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
