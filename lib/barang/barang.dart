import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'package:medang_caffe/barang/widget/addbarang/addbarang.dart';
import 'package:medang_caffe/barang/widget/list/listbarang.dart';
import 'package:medang_caffe/barang/widget/totalup.dart';
import 'package:medang_caffe/barang/widget/search.dart';

import '../controller/barangcontroller.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Barang extends StatefulWidget {
  @override
  _BarangState createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  late StreamSubscription<bool> keyboardSubscription;
  bool flo = false;
  Getbarang b = Get.put(Getbarang());
  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        flo = visible;
      });
    });
    /*KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          flo = visible;
        });
      },
    );*/
  }

  void dispose() {
    // Cancel the subscription to avoid memory leaks
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(
            "Barang",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.to(
                    Search(),
                  );
                },
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TotalUp(),
              ListBarang(),
            ],
          ),
        ),
        floatingActionButton: !flo
            ? FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                onPressed: () {
                  Get.bottomSheet(
                    AddBaranG(),
                    isScrollControlled: true,
                  );
                },
                child: Icon(
                  Icons.store_mall_directory_outlined,
                  color: Colors.white,
                ),
              )
            : null);
  }
}
