import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppBarForm extends StatelessWidget with PreferredSizeWidget{

  String titleAppBar;

  AppBarForm(String t){
    titleAppBar = t;
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleAppBar),
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
    );
  }
}
