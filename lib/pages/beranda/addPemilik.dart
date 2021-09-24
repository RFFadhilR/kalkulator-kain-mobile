import 'dart:math';

import 'package:apk_bapak/model/modelPemilik.dart';
import 'package:apk_bapak/widget/appBar.dart';
import 'package:apk_bapak/widget/item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sweetalert/sweetalert.dart';

class TambahPemilik extends StatefulWidget {
  const TambahPemilik({Key key}) : super(key: key);

  @override
  _TambahPemilikState createState() => _TambahPemilikState();
}

class _TambahPemilikState extends State<TambahPemilik> {
  String valuenamapemilik = "";

  Random random = Random();

  CollectionReference cfPemilik =
      FirebaseFirestore.instance.collection("pemilik");

  modalText(
    BuildContext context,
    String label,
    String type,
    String value,
  ) {
    var hsl = TextEditingController();
    hsl.text = value == "null" ? "" : value;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: MediaQuery.of(context).viewInsets,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      label,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  maxLines: 5,
                  controller: hsl,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: "Masukkan " + label,
                  ),
                ),
              ),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor("#42275a"),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ElevatedButton(
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        valuenamapemilik = hsl.text.toString();

                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarForm("Tambah Pemilik"),
      body: Container(
        color: Colors.grey.shade300,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  item(
                    context,
                    "Nama Pemilik",
                    valuenamapemilik,
                    false,
                    () => modalText(
                      context,
                      "Nama Pemilik",
                      "",
                      valuenamapemilik,
                    ),
                    true,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  title: "Maaf...",
                  desc: "Apakah data yang Anda masukkan sudah betul semua?",
                  headerAnimationLoop: false,
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: false,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.QUESTION,
                  btnOkText: "Iyaa",
                  btnCancelText: "Tidak",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    SweetAlert.show(
                      context,
                      title: "Loading...",
                      style: SweetAlertStyle.loading,
                    );

                    String id = "P-" + random.nextInt(9999).toString();

                    final mPemilik = Pemilik(
                      id,
                      valuenamapemilik,
                      DateTime.now().toString(),
                      DateTime.now().toString(),
                    );

                    cfPemilik.doc(id).set(mPemilik.toJson()).then((value) {
                      Navigator.of(context).pop();

                      AwesomeDialog(
                        context: context,
                        title: "Yeay...",
                        desc: "Berhasil menambahkan data Pemilik",
                        btnOkText: "OK",
                        headerAnimationLoop: false,
                        dismissOnBackKeyPress: false,
                        dismissOnTouchOutside: false,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.SUCCES,
                        btnOkOnPress: () => Navigator.of(context).pop(),
                      )..show();
                    }).catchError((e) {
                      Navigator.of(context).pop();

                      AwesomeDialog(
                        context: context,
                        title: "Error...",
                        desc: "Gagal menambahkan data Pemilik, e = " +
                            e.toString(),
                        btnOkText: "OK",
                        headerAnimationLoop: false,
                        dismissOnBackKeyPress: false,
                        dismissOnTouchOutside: false,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.ERROR,
                        btnOkOnPress: () {},
                      )..show();
                    });
                  },
                )..show();
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(15),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save_rounded,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3),
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
