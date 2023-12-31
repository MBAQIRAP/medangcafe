import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medang_caffe/firebase_options.dart';
import 'package:medang_caffe/transaksi/transaksi.dart';
import 'package:permission_handler/permission_handler.dart';

import 'menu/menu.dart';
import 'controller/menucontroller.dart';
import 'controller/transaksicontroller.dart';
import 'laporan/laporan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('id_ID').then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: "m",
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.black
        ),
      ),
      debugShowCheckedModeBanner: false,
      color: Colors.grey.shade100,
      home: Wrap(),
    );
  }
}

class Wrap extends StatefulWidget {
  @override
  _WrapState createState() => _WrapState();
}

class _WrapState extends State<Wrap> {
  int hlm = 0;
  PageController p = PageController(initialPage: 0, keepPage: true);
  Getmenu b = Get.put(Getmenu());
  TransaksiController t = Get.put(TransaksiController());
  @override
  void initState() {
    b.getmenu();
    t.gettransaksi();
    b.getmakanan();
    b.getminuman();
    t.gettransmakanan();
    t.getchart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: p,
        children: [
          Transaksi(),
          Menu(),
          Laporan(),
        ],
        onPageChanged: (value) {
          setState(() {
            hlm = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            hlm = value;
            p.animateToPage(value,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          });
        },
        currentIndex: hlm,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.swap_horiz_rounded,
              ),
              label: "Transaksi"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant_menu,
              ),
              label: "Menu"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.paste_rounded,
              ),
              label: "Laporan"),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
      ),
    );
  }
}
