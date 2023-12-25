import 'package:flutter/material.dart';

class CustAlert {
  void showAlrtDailog(BuildContext context, String title, String message,
      Function onPress, String buttonTitle) {
//flutter define function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //return object of type dialoge
        return AlertDialog(
          title: new Text("$title \n"),
          content: new Text(message ?? "Empty"),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                "$buttonTitle",
                style: TextStyle(color: Color(0XFF31C8AE)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPress != null) {
                  onPress();
                }
              },
            )
          ],
        );
      },
    );
  }
}
