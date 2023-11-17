import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransaksiController extends GetxController {
  List transaksi = [];
  CollectionReference dbtransaksi =
  FirebaseFirestore.instance.collection('transaksi');

  addtransaksi({var data, required int bayar}) async {
    await dbtransaksi.add({
      'data': data,
      'bayar': bayar,
      'tgl': DateTime.now(),
    });
    update();
  }

  Stream<QuerySnapshot> gettransaksi() {
    transaksi.clear();
    Stream<QuerySnapshot> stream = dbtransaksi
        .orderBy('tgl', descending: true)
        .snapshots(includeMetadataChanges: true);

    stream.listen((querySnapshot) {
      transaksi.clear();
      querySnapshot.docs.forEach((res) {
        transaksi.add(
          {
            'id': res.id,
            'data': res.data(),
          },
        );
        update();
      },);
      update();
    },);
    return stream;
  }
}
