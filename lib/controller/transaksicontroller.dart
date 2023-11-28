import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransaksiController extends GetxController {
  List transaksi = [];
  List transaksichart= [];
  List transmakanan = [];
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
          },);
      },);
      update();
    },);
    update();
    return stream;
  }

  Stream<QuerySnapshot> gettransmakanan() {
    // Clear the existing transmakanan list
    transmakanan.clear();

    Stream<QuerySnapshot> stream = dbtransaksi
        .orderBy('tgl', descending: true)
        .snapshots(includeMetadataChanges: true);

    stream.listen((querySnapshot) {
      transmakanan.clear();
      // Create a map to store the aggregated counts and kategori information
      Map<String, Map<String, dynamic>> transmakananMap = {};

      querySnapshot.docs.forEach((res) {
        // Check if data is not null
        if (res.data() != null) {
          Map<String, dynamic> data = res.data()! as Map<String, dynamic>;
          List<dynamic> items = data['data'];

          items.forEach((item) {
            String itemName = item['nama'];
            int jumlahBeli = item['jumlahbeli'];
            String kategori = item['kategori'];

            // Update the aggregated count for the item name and store kategori information
            if (!transmakananMap.containsKey(itemName)) {
              transmakananMap[itemName] = {
                'jumlahbeli': 0,
                'kategori': kategori,
              };
            }
            transmakananMap[itemName]!['jumlahbeli'] += jumlahBeli;
          });
        }
      });

      // Update the transmakanan list with the aggregated counts and kategori information
      transmakananMap.forEach((nama, data) {
        if (!transmakanan.any((item) => item['nama'] == nama)) {
        transmakanan.add({
          'nama': nama,
          'jumlahbeli': data['jumlahbeli'],
          'kategori': data['kategori'],
        });
        }
      });

      // Print the transmakanan list for debugging

      // Assuming you have an update function to refresh the UI
      update();
    });

    // Assuming you have an update function to refresh the UI
    update();

    return stream;
  }

  Stream<QuerySnapshot> getchart() {
    // Clear the existing transaksichart list
    transaksichart.clear();

    Stream<QuerySnapshot> stream = dbtransaksi
        .orderBy('tgl', descending: true)
        .snapshots(includeMetadataChanges: true);

    stream.listen((querySnapshot) {
      transaksichart.clear();
      // Create a map to store the aggregated counts
      Map<String, Map<String, dynamic>> transaksichartMap = {};

      querySnapshot.docs.forEach((res) {
        // Check if data is not null
        if (res.data() != null) {
          Map<String, dynamic> data = res.data()! as Map<String, dynamic>;
          Timestamp tanggal = data['tgl'] as Timestamp;
          DateTime dateTime = tanggal.toDate();
          String formattedDate = DateFormat('MMM d').format(dateTime);

          if (transaksichartMap.containsKey(formattedDate)) {
            // If the date is already in the map, increment the 'jumlah'
            transaksichartMap[formattedDate]!['jumlah'] += 1;
          } else {
            // If the date is not in the map, insert a new entry with 'jumlah' as 1
            transaksichartMap[formattedDate] = {
              'tgl': formattedDate,
              'jumlah': 1,
            };
          }
        }
      });

      // Update the transaksichart list with the aggregated counts
      transaksichartMap.forEach((formattedDate, data) {
        if (!transaksichart.any((item) => item['tgl'] == formattedDate)) {
          transaksichart.add({
            'tgl': formattedDate,
            'jumlah': data['jumlah'],
          });
        }
      });
      update();
    });

    // Assuming you have an update function to refresh the UI
    update();

    return stream;
  }

}