import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../controller/barangcontroller.dart';
import '../../../manage/listfilter.dart';

class Filte extends StatefulWidget {
  @override
  _FilteState createState() => _FilteState();
}

class _FilteState extends State<Filte> {
  Getbarang b = Get.put(Getbarang());
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        height: 120,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.black,
          //   width: 3,
          // ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              "Filter Menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ResponsiveGridRow(children: [
              for (var a in filters)
                ResponsiveGridCol(
                  xs: 4,
                  md: 4,
                  sm: 4,
                  child: InkWell(
                      onTap: () {
                        print(a);
                        b.filter.value = a;
                        Get.back();
                        b.update();
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(a,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ]),
          ],
        ),
      ),
    );
  }
}
