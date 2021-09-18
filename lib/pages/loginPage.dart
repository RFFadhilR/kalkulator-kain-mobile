import 'dart:developer';

import 'package:apk_bapak/model/modelAkun.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sweetalert/sweetalert.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleSignInAccount user;
  final googleSignIn = GoogleSignIn();
  DatabaseReference akun = FirebaseDatabase.instance.reference().child("akun");
  CollectionReference cAkun = FirebaseFirestore.instance.collection("akun");

  signInWithGoogle() async {
    Navigator.of(context).pop();
    final googleUser = await googleSignIn.signIn();
    user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    final cUser = FirebaseAuth.instance.currentUser;

    final akuns = Akun(
      cUser.providerData[0].uid == null
          ? ""
          : cUser.providerData[0].uid.toString(),
      cUser.providerData[0].displayName == null
          ? ""
          : cUser.providerData[0].displayName.toString(),
      cUser.providerData[0].email == null
          ? ""
          : cUser.providerData[0].email.toString(),
      "0",
      cUser.providerData[0].phoneNumber == null
          ? ""
          : cUser.providerData[0].phoneNumber.toString(),
      cUser.providerData[0].photoURL == null
          ? ""
          : cUser.providerData[0].photoURL.toString(),
      DateTime.now().toString(),
      DateTime.now().toString(),
    );

    cAkun.get().then((value) {
      value.docs.forEach((element) {
        if (element.id != cUser.uid) {
          cAkun.doc(cUser.uid)
              .set(akuns.toJson())
              .then((value) => print("Berhasil"))
              .catchError((e) => print("Error : " + e.toString()));
        }
      });
    });

    AwesomeDialog(
      context: context,
      title: "Yeay...",
      desc: "Anda berhasil untuk Masuk !",
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      autoHide: Duration(seconds: 3),
    )
      ..show();

    Future.delayed(Duration(seconds: 3), () async {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MyApp(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.grey.shade300,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor("#42275a"), HexColor("#734b6d")],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  SweetAlert.show(
                    context,
                    title: "Loading...",
                    style: SweetAlertStyle.loading,
                  );
                  Future.delayed(
                    Duration(seconds: 3),
                        () => signInWithGoogle(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Image.network(
                          "https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_1080,q_100,w_1080/v1/gcs/platform-data-dsc/events/index_RFkQwzb.png",
                          width: size.width * 0.05,
                        ),
                      ),
                      Text("Masuk dengan Google"),
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
