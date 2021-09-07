import 'package:apk_bapak/pages/berandaview/jeniskainView.dart';
import 'package:apk_bapak/pages/berandaview/kainView.dart';
import 'package:apk_bapak/pages/berandaview/pemilikView.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: HexColor("#5D26C1"),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor("#42275a"), HexColor("#734b6d")],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            /// Head - TabBar
            Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  width: size.width,
                  // color: HexColor("#5D26C1"),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [HexColor("#42275a"), HexColor("#734b6d")],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
                  height: 40,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 40,
                        child: TabBar(
                          labelColor: HexColor("#5D26C1"),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: HexColor("#5D26C1"),
                          tabs: [
                            Tab(
                              text: "Kain",
                            ),
                            Tab(
                              text: "Jenis Kain",
                            ),
                            Tab(
                              text: "Pemilik",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// Body
            Flexible(
              child: TabBarView(
                children: [
                  /// TabView Kain
                  KainView(),

                  /// TabView Jenis Kain
                  JenisKainView(),

                  /// TabView Pemilik
                  PemilikView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
