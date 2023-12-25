import 'package:flutter/material.dart';

class ErrorAlert {
  void showErrorDailog(BuildContext context, String title, String message,
      Function onPress, bool cancelButton) {
//flutter define function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //return object of type dialoge
        return AlertDialog(
          title: new Text("$title \n"),
          content: new Text(message ?? "Empty"),
          actions: <Widget>[
            cancelButton
                ? FlatButton(
                    child: new Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : Offstage(),
            FlatButton(
              child: new Text(
                "Ok",
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
