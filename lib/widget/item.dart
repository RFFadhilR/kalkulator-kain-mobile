import 'package:flutter/material.dart';

item(
  BuildContext context,
  String title,
  String value,
  bool isLoading,
  Function action,
  bool divider,
) {
  var size = MediaQuery.of(context).size;

  return InkWell(
    onTap: action,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: size.width,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(value),
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: isLoading
                        ? Container(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(),
                          )
                        : Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
        divider
            ? SizedBox(
                height: 3,
                child: Container(
                  color: Colors.grey.shade300,
                ),
              )
            : SizedBox(),
      ],
    ),
  );
}
