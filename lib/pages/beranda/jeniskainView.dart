import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

import 'addJenisKain.dart';

class JenisKainView extends StatefulWidget {
  const JenisKainView({Key key}) : super(key: key);

  @override
  _JenisKainViewState createState() => _JenisKainViewState();
}

class _JenisKainViewState extends State<JenisKainView> {
  var etCari = TextEditingController();

  bool isCari = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          /// View Search
          Container(
            child: Row(
              children: [
                /// Field Cari
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: etCari,
                            cursorColor: HexColor("#5D26C1"),
                            onTap: () {
                              setState(() {
                                isCari = true;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Cari",
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        FocusScope.of(context).hasFocus && isCari
                            ? GestureDetector(
                                onTap: () {
                                  etCari.clear();
                                  FocusScope.of(context).unfocus();
                                  isCari = false;
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),

                /// Button Tambah
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TambahJenisKain(),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 10, 10),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          ),

          /// View List Data
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("jenis_kain")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade200,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return snapshot.data.docs.length != 0
                    ? ListView(
                        children: snapshot.data.docs.map((e) {
                          return Container(
                            width: size.width,
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e['nama_jenis_kain'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Satuan Kain"),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Divider(
                                                        color: Colors.black,
                                                        endIndent: 10,
                                                        indent: 10,
                                                      ),
                                                      Divider(
                                                        color: Colors.black,
                                                        endIndent: 10,
                                                        indent: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(e['satuan_kain_kg'] +
                                                        " (kg)"),
                                                    Text(e['satuan_kain_m'] +
                                                        " (m)")
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.black,
                                    indent: 5,
                                    endIndent: 5,
                                    width: 0,
                                  ),
                                  IntrinsicWidth(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit_rounded,
                                                color: Colors.blue,
                                                size: 20,
                                              ),
                                              Text(
                                                "Sunting",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          height: 0,
                                          indent: 5,
                                          endIndent: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete_rounded,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              Text(
                                                "Hapus",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : Center(
                        child: Text("Data tidak tersedia"),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
