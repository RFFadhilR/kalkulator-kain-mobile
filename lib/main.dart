import 'package:apk_bapak/pages/berandaPage.dart';
import 'package:apk_bapak/pages/kalkulatorPage.dart';
import 'package:apk_bapak/pages/loginPage.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:palette_generator/palette_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: LoginPage(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var indexBottom = 0;
  List colors;
  PaletteGenerator generator;

  @override
  void initState() {
    _coba();
    super.initState();
  }

  _coba() async {
    generator = await PaletteGenerator.fromImageProvider(
        AssetImage("assets/images/coba.png"));
    print(generator.dominantColor.color);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        /// BottomView Beranda
        BerandaPage(),

        /// BottomView Kalkulator
        KalkulatorPage(),
      ][indexBottom],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey, blurRadius: 5),
        ]),
        child: BottomNavyBar(
          animationDuration: Duration(milliseconds: 250),
          selectedIndex: indexBottom,
          onItemSelected: (value) => setState(() {
            indexBottom = value;
          }),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          containerHeight: 50,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.home_rounded),
                title: Text("Beranda"),
                textAlign: TextAlign.center,
                activeColor: HexColor("#5D26C1"),
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.calculate_rounded),
                title: Text("Kalkulator"),
                textAlign: TextAlign.center,
                activeColor: HexColor("#5D26C1"),
                inactiveColor: Colors.black),
          ],
        ),
      ),
    );
  }
}
