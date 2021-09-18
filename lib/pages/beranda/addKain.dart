import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TambahDataKain extends StatefulWidget {
  const TambahDataKain({Key key}) : super(key: key);

  @override
  _TambahDataKainState createState() => _TambahDataKainState();
}

class _TambahDataKainState extends State<TambahDataKain> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Kain"),
        elevation: 0,
        // backgroundColor: HexColor("#5D26C1"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor("#42275a"),
                HexColor("#734b6d"),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: size.width,
                  child: Row(
                    children: [
                      Icon(
                        Icons.save_rounded,
                        color: Colors.white,
                      ),
                      Container(
                        child: Text(
                          "Simpan",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
