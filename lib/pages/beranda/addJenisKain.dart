import 'dart:math';

import 'package:apk_bapak/model/modalJenisKain.dart';
import 'package:apk_bapak/widget/appBar.dart';
import 'package:apk_bapak/widget/item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sweetalert/sweetalert.dart';

class TambahJenisKain extends StatefulWidget {
  const TambahJenisKain({Key key}) : super(key: key);

  @override
  _TambahJenisKainState createState() => _TambahJenisKainState();
}

class _TambahJenisKainState extends State<TambahJenisKain> {
  String valuejeniskain = "";
  String valuesatuankg = "";
  String valuesatuanm = "";

  Random random = Random();

  CollectionReference cfJenisKain =
      FirebaseFirestore.instance.collection("jenis_kain");

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
                child: type == "jeniskain"
                    ? TextField(
                        maxLines: 5,
                        controller: hsl,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: "Masukkan " + label,
                        ),
                      )
                    : type == "satuankg"
                        ? TextField(
                            maxLines: 5,
                            controller: hsl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              hintText: "Masukkan " + label,
                            ),
                          )
                        : type == "satuanm"
                            ? TextField(
                                maxLines: 5,
                                controller: hsl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintText: "Masukkan " + label,
                                ),
                              )
                            : Container(),
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
                        if (type == "jeniskain") {
                          valuejeniskain = hsl.text.toString();
                        } else if (type == "satuankg") {
                          valuesatuankg = hsl.text.toString();
                        } else if (type == "satuanm") {
                          valuesatuanm = hsl.text.toString();
                        }

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
      appBar: AppBarForm("Tambah Jenis Kain"),
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
                    "Nama Jenis Kain",
                    valuejeniskain,
                    false,
                    () => modalText(
                      context,
                      "Nama Jenis Kain",
                      "jeniskain",
                      valuejeniskain,
                    ),
                    true,
                  ),
                  item(
                    context,
                    "Satuan Kain ( kg )",
                    valuesatuankg,
                    false,
                    () => modalText(
                      context,
                      "Satuan Kain ( kg )",
                      "satuankg",
                      valuesatuankg,
                    ),
                    true,
                  ),
                  item(
                    context,
                    "Satuan Kain ( m )",
                    valuesatuanm,
                    false,
                    () => modalText(
                      context,
                      "Satuan Kain ( m )",
                      "satuanm",
                      valuesatuanm,
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

                    String id = "JK-" + random.nextInt(9999).toString();

                    final mJenis = JenisKain(
                      id,
                      valuejeniskain,
                      valuesatuankg,
                      valuesatuanm,
                      DateTime.now().toString(),
                      DateTime.now().toString(),
                    );

                    cfJenisKain.doc(id).set(mJenis.toJson()).then((value) {
                      Navigator.of(context).pop();

                      AwesomeDialog(
                        context: context,
                        title: "Yeay...",
                        desc: "Berhasil menambahkan data Jenis Kain",
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
                        desc: "Gagal menambahkan data Jenis Kain, e = " +
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
