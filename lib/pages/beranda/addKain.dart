import 'dart:io';

import 'package:apk_bapak/widget/appBar.dart';
import 'package:apk_bapak/widget/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

class TambahDataKain extends StatefulWidget {
  const TambahDataKain({Key key}) : super(key: key);

  @override
  _TambahDataKainState createState() => _TambahDataKainState();
}

class _TambahDataKainState extends State<TambahDataKain> {
  String valuejeniskain = "";
  String valuepemilik = "";
  String valuewarna = "";
  String valuenamawarna = "";
  String valuetotalkain = "";
  String tambahjeniskain = "";
  String tambahpemilik = "";

  bool isLoadingWarna = false;

  final picker = ImagePicker();

  PaletteGenerator generator;
  
  CollectionReference cfJenisKain = FirebaseFirestore.instance.collection("jenis_kain");
  CollectionReference cfPemilik = FirebaseFirestore.instance.collection("pemilik");

  DocumentSnapshot variable;

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
                child: type == "namakain"
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
                    : type == "totalkain"
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
                        if (type == "namakain") {
                          valuenamawarna = hsl.text.toString();
                        } else if (type == "totalkain") {
                          valuetotalkain = hsl.text.toString();
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

  modalJenisKain(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: MediaQuery.of(context).viewInsets,
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Jenis Kain",
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
                // padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2.2),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          new Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("jenis_kain")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .width /
                                      (MediaQuery.of(context).size.height / 6),
                                  controller: new ScrollController(
                                    keepScrollOffset: true,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: snapshot.data.docs.map((e) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: HexColor("#42275a"),
                                        ),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: FlatButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              e['nama_jenis_kain'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: HexColor("#42275a"),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 3),
                                              child: Visibility(
                                                visible: false,
                                                child: Icon(
                                                  Icons.done_rounded,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hasiljeniskain(e['id_jenis_kain']);
                                            tambahjeniskain = e['id_jenis_kain'];
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  modalPemilik(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: MediaQuery.of(context).viewInsets,
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Pemilik",
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
                // padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2.2),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          new Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("pemilik")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .width /
                                      (MediaQuery.of(context).size.height / 6),
                                  controller: new ScrollController(
                                    keepScrollOffset: true,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: snapshot.data.docs.map((e) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: HexColor("#42275a"),
                                        ),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: FlatButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              e['nama_pemilik'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: HexColor("#42275a"),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 3),
                                              child: Visibility(
                                                visible: false,
                                                child: Icon(
                                                  Icons.done_rounded,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hasilpemilik(e['id_pemilik']);
                                            tambahpemilik = e['id_pemilik'];
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bukaKamera() async {
    setState(() {
      isLoadingWarna = true;
    });
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    generator = await PaletteGenerator.fromImageProvider(
      FileImage(
        File(pickedFile.path),
      ),
    );

    setState(() {
      isLoadingWarna = false;
      valuewarna = generator.dominantColor.color.toString();
    });
  }

  hasiljeniskain(String value) {
    cfJenisKain.doc(value).get().then((value) {
      setState(() {
        valuejeniskain = value['nama_jenis_kain'];
      });
    });
  }

  hasilpemilik(String value) {
    cfPemilik.doc(value).get().then((value) {
      setState(() {
        valuepemilik = value['nama_pemilik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarForm("Tambah Kain"),
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
                    "Jenis Kain",
                    valuejeniskain,
                    false,
                    () => modalJenisKain(context),
                    true,
                  ),
                  item(
                    context,
                    "Pemilik",
                    valuepemilik,
                    false,
                    () => modalPemilik(context),
                    true,
                  ),
                  item(
                    context,
                    "Warna",
                    valuewarna,
                    isLoadingWarna,
                    () => bukaKamera(),
                    true,
                  ),
                  item(
                    context,
                    "Nama Warna",
                    valuenamawarna,
                    false,
                    () => modalText(
                      context,
                      "Nama Warna",
                      "namakain",
                      "",
                    ),
                    true,
                  ),
                  item(
                    context,
                    "Total Kain",
                    valuetotalkain,
                    false,
                    () => modalText(
                      context,
                      "Total Kain",
                      "totalkain",
                      valuetotalkain,
                    ),
                    false,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
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
