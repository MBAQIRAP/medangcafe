import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'package:medang_caffe/menu/widget/addmenu/addmenu.dart';
import 'package:medang_caffe/menu/widget/list/listmenu.dart';
import 'package:medang_caffe/menu/widget/totalup.dart';
import 'package:medang_caffe/menu/widget/search.dart';

import '../controller/menucontroller.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late StreamSubscription<bool> keyboardSubscription;
  bool flo = false;
  Getmenu b = Get.put(Getmenu());
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
            "Menu",
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
              ListMenu(),
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
                    AddMenu(),
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
