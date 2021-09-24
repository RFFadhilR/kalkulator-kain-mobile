import 'package:apk_bapak/pages/beranda/berandaPage.dart';
import 'package:apk_bapak/pages/kalkulator/kalkulatorPage.dart';
import 'package:apk_bapak/pages/login/loginPage.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var cUser = FirebaseAuth.instance.currentUser;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),

      /// home: LoginPage(),
      /// home: MyApp(),
      home: cUser == null ? LoginPage() : MyApp(),
      // home: Coba(),
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
