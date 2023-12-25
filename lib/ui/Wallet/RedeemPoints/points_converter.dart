import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Home/wallet_apis.dart';

class PointsConverter extends StatefulWidget {
  final Function(int) pointValue;
  final Function(int) amountValue;
  const PointsConverter({
    Key key,
    @required this.pointValue,
    @required this.amountValue,
  }) : super(key: key);

  @override
  _PointsConverterState createState() => _PointsConverterState();
}

class _PointsConverterState extends State<PointsConverter> {
  int currentworth = 0;
  TextEditingController pointsController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool amountValid = true;

  @override
  void initState() {
    getWalletDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0XFF4E5253))),
                    width: MediaQuery.of(context).size.width - 64,
                    // height: 48,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                // LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: pointsController,
                              decoration: InputDecoration(
                                hintText: "Enter Points",
                                contentPadding: EdgeInsets.all(0),
                                suffix: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFFEDFFF5),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  width: 140,
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                    "Worth: ₹$currentworth",
                                    style: TextStyle(fontSize: 16),
                                  )),
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              style: TextStyle(fontSize: 16),
                              // validator: (value) {
                              //   if (value.length > 0) {
                              //     if (int.parse(value) > currentBalance) {
                              //       return "Please enter the points less than or equal to the current balance";
                              //     } else {
                              //       return null;
                              //     }
                              //   } else {
                              //     return null;
                              //   }
                              // },
                              onChanged: (change) {
                                if (pointsController.text.length > 0) {
                                  // _formKey.currentState.validate();
                                  setState(() {
                                    currentworth =
                                        (double.parse(pointsController.text) *
                                                conversionRate)
                                            .toInt();
                                  });
                                  if (int.parse(change) > currentBalance) {
                                    widget.pointValue(null);
                                    widget.amountValue(null);
                                    setState(() {
                                      amountValid = false;
                                    });
                                  } else {
                                    widget.pointValue(
                                        int.parse(pointsController.text));
                                    widget.amountValue(currentworth);
                                    setState(() {
                                      amountValid = true;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    currentworth = 0;
                                  });
                                }
                                _formKey.currentState.validate();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  amountValid
                      ? Offstage()
                      : Column(
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Please enter the points less than or equal to the current balance",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.red[700]),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
