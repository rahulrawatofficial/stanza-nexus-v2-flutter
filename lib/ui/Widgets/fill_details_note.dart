import 'package:flutter/material.dart';

class FillDetailsNote extends StatelessWidget {
  const FillDetailsNote({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Color(0XFFFFEAB6)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
            "Please fill in your details carefully to ensure that you receive the referral amount"),
      ),
    );
  }
}
