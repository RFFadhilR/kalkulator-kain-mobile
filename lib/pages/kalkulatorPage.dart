import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({Key key}) : super(key: key);

  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: HexColor("#5D26C1"),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              HexColor("#42275a"),
              HexColor("#734b6d"),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
        ),
      ),
    );
  }
}
