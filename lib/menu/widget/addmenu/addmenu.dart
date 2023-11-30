import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/menucontroller.dart';

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  String? kategori;
  late String barcode;
  Getmenu b = Get.put(Getmenu());

  Widget sc({required String hint, required TextEditingController c, required TextInputType tp}) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 15, right: 0, bottom: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: TextField(
        keyboardType: tp,
        onChanged: (value) {
          setState(() {});
        },
        cursorColor: Colors.black,
        style: TextStyle(
          fontSize: 13,
        ),
        controller: c,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: Get.height / 2,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              "Tambah Menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            sc(hint: "Nama menu", c: nama, tp: TextInputType.text),
            SizedBox(
              height: 20,
            ),
            sc(hint: "Harga satuan", c: harga, tp: TextInputType.number),
            SizedBox(
              height: 20,
            ),
            sc(hint: "Jumlah", c: jumlah, tp: TextInputType.number),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: RadioListTile(
                          title: Text("Makanan"),
                          value: "makanan",
                          groupValue: kategori,
                          onChanged: (value){
                            setState(() {
                              kategori = value! as String;
                              print(kategori);
                            });
                          }
                      ),
                  ),
                  Expanded(
                    child: RadioListTile(
                        title: Text("Minuman"),
                        value: "minuman",
                        groupValue: kategori,
                        onChanged: (value){
                          setState(() {
                            kategori = value! as String;
                          });
                        }
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            nama.text.length <= 0 ||
                    harga.text.length <= 0 ||
                    jumlah.text.length <= 0 ||
                    kategori == null
                ? FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.save_outlined,
                      color: Colors.grey,
                    ),
                  )
                : FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      b.addmenu(
                        nama: nama.text,
                        kategori: kategori!,
                        harga: int.parse(harga.text),
                        jumlah: int.parse(jumlah.text),
                      );
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                    },
                    child: Icon(
                      Icons.save_outlined,
                      color: Colors.white,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
