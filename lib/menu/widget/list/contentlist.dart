
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../controller/menucontroller.dart';
import '../../../manage/formater.dart';

class Expa extends StatefulWidget {
  final String? id;
  final String? nama;
  final int? harga;
  final int? stock;
  String? kategori;
  Expa({this.id, this.nama, this.harga, this.stock, this.kategori});
  @override
  _ExpaState createState() => _ExpaState();
}

class _ExpaState extends State<Expa> {
  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stock = TextEditingController();
  String? kategori;
  bool ex = false;
  Getmenu b = Get.put(Getmenu());
  @override
  void initState() {
    super.initState();
    kategori = widget.kategori;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: [
        IconSlideAction(
          caption: 'Hapus',
          color: Colors.transparent,
          icon: Icons.delete_outline_rounded,
          foregroundColor: Colors.black,
          onTap: () {
            b.deletmenu(id: widget.id!, nama: widget.nama!);
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: 'Hapus',
          color: Colors.transparent,
          icon: Icons.delete_outline_rounded,
          foregroundColor: Colors.black,
          onTap: () {
            b.deletmenu(id: widget.id!, nama: widget.nama!);
          },
        ),
      ],

      // actionExtentRatio: 0.25,
      child: Theme(
        data: ThemeData(fontFamily: 'm').copyWith(
          dividerColor: Colors.transparent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.black
          ),
          focusColor: Colors.black,
          primaryColor: Colors.black,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          backgroundColor: Colors.white,
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Icon(Icons.restaurant_menu, color: Colors.black),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nama!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: ex ? Colors.black : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    uang.format(widget.harga),
                    style: TextStyle(
                      fontSize: 13,
                      color: ex
                          ? Colors.black.withOpacity(0.6)
                          : Colors.black.withOpacity(0.6),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.stock! <= 5 ? Colors.red : Colors.green,
                ),
                child: Text(
                  widget.stock.toString(),
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              )
            ],
          ),
          trailing: RotatedBox(
            quarterTurns: !ex ? 0 : 45,
            child: Icon(Icons.chevron_right_rounded),
          ),
          children: [
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "Nama",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    cursorColor: Colors.black,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    controller: nama,
                    decoration: InputDecoration(
                      hintText: "Nama",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ResponsiveGridRow(children: [
              ResponsiveGridCol(
                xs: 6,
                md: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Harga",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 15, right: 7.5),
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {});
                        },
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        controller: harga,
                        decoration: InputDecoration(
                          hintText: "Harga",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ResponsiveGridCol(
                xs: 6,
                md: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Jumlah",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 7.5, right: 15),
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {});
                        },
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        controller: stock,
                        decoration: InputDecoration(
                          hintText: "Jumlah",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
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
                        kategori = value as String;
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
                        kategori = value as String;
                        print(kategori);
                      });
                    }
                ),
              ),
            ],
          ),
        ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  b.editmenu(
                    id: widget.id!,
                    nama: nama.text,
                    kategori: kategori!,
                    harga: int.parse(harga.text),
                    stock: int.parse(stock.text),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  height: 40,
                  width: Get.width / 3,
                  decoration: BoxDecoration(
                    color: nama.text.length <= 0 ||
                            harga.text.length <= 0 ||
                            stock.text.length <= 0 ||
                                nama.text == widget.nama &&
                                harga.text == widget.harga.toString() &&
                                stock.text == widget.stock.toString() &&
                                kategori == widget.kategori.toString()
                        ? Colors.grey.shade200
                        : Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Simpan",
                    style: TextStyle(
                      color: nama.text.length <= 0 ||
                              harga.text.length <= 0 ||
                              stock.text.length <= 0 ||
                              kategori == null
                          ? Colors.grey
                          : Colors.white,
                      fontSize: 13,
                    ),
                  )),
                ),
              ),
            )
          ],
          onExpansionChanged: (value) {
            setState(() {
              if (value == false) {
                nama.text.length <= 0
                    ? nama.text = widget.nama!
                    : nama.text = nama.text;
                harga.text.length <= 0
                    ? harga.text = widget.harga.toString()
                    : harga.text = harga.text;
                stock.text.length <= 0
                    ? stock.text = widget.stock.toString()
                    : stock.text = stock.text;
                kategori == null
                    ? kategori = widget.kategori.toString()
                    : kategori = kategori;
              }
              if (value == true) {
                nama.text = widget.nama!;
                harga.text = widget.harga.toString();
                stock.text = widget.stock.toString();
                kategori = widget.kategori.toString();
              }
              ex = value;
            });
          },
        ),
      ),
    );
  }
}
