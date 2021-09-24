import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';

import '../login/loginPage.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({Key key}) : super(key: key);

  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  final googleSignIn = GoogleSignIn();

  logout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: HexColor("#5D26C1"),
        actions: [
          IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                title: "Maaf...",
                desc: "Apakah anda yakin untuk Keluar ?",
                headerAnimationLoop: false,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                dialogType: DialogType.QUESTION,
                animType: AnimType.SCALE,
                btnOkText: "Iyaa",
                btnCancelText: "Tidak",
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  logout();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.SCALE,
                    desc: "Anda berhasil untuk Keluar !",
                    dismissOnTouchOutside: false,
                    dismissOnBackKeyPress: false,
                    headerAnimationLoop: false,
                    btnOkText: "Iyaa",
                    btnOkOnPress: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    ),
                  )..show();
                },
              )..show();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
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
            ),
          ),
        ),
      ),
    );
  }
}
