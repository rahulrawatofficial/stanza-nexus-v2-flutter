import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/tds_info_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/KYCDetails/id_details_screen.dart';

class TdsTile extends StatefulWidget {
  @required
  final Function reload;
  @required
  final TdsInfo data;
  const TdsTile({Key key, this.reload, this.data}) : super(key: key);

  @override
  _TdsTileState createState() => _TdsTileState();
}

class _TdsTileState extends State<TdsTile> {
  bool showTile = true;

  bottomSheetButtonContinue() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white, // or some other color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Image.asset(
                        "assets/close.png",
                        height: 24,
                        width: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Are you sure you want to continue? ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0XFF232728),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "TDS once deducted will not be refunded. You can upload PAN card details later. Post verification, TDS deduction will be ${widget.data.tdsWithPan} for every successive payout.",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => IdDetailsScreen(
                                        reload: widget.reload,
                                      )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Color(0XFF60C3AD),
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Color(0XFF60C3AD),
                                ),
                              ),
                              width: 164,
                              height: 49,
                              child: Center(
                                child: Text(
                                  "NO, UPLOAD PAN",
                                  style: TextStyle(
                                    color: Color(0XFF60C3AD),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              // onPressed: () {},
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeTds().then((value) {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0XFF60C3AD),
                                borderRadius: BorderRadius.circular(4.0),
                              ),

                              width: 164,
                              height: 49,
                              child: Center(
                                child: Text(
                                  "CONFIRM ${widget.data.tdsWithoutPan} TDS",
                                  style: TextStyle(
                                    // fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              // onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getTdsDetails() async {
    var params = {"partnerId": "${userData.partnerId}"};
    final response = await ApiBase()
        .get(context, "/mlm-service/getPartnerKYCDetails", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data;
    } else {
      return null;
    }
  }

  Future changeTds() async {
    var params = {"brokerMobile": "${userData.mobileNumber}"};
    final response = await ApiBase()
        .put(context, "/mlm-service/updateTdsPercentageToMax", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        showTile = false;
      });
      return data;
    } else {
      return null;
    }
  }

  // reloadPage() {
  //   setState(() {
  //     // showTile = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (showTile) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Color(0XFFFFF1F1)),
          // color: color,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0XFFFFFFFF),
                                  // backgroundImage: AssetImage(iconAsset),
                                  child: Image.asset(
                                    "assets/points.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "TDS Deduction",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 64,
                              child: Text(
                                "Post ${widget.data.amount} cumulative payouts, you can opt to either continue receiving money in your account/wallet with ${widget.data.tdsWithoutPan} TDS deductions or update your PAN card details. Post the verification of the PAN card, ${widget.data.tdsWithPan} TDS will be deducted for every successive payout. ",
                                style: TextStyle(
                                    // fontSize: 20,
                                    // fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 64,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        bottomSheetButtonContinue();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Color(0XFF60C3AD),
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                            color: Color(0XFF60C3AD),
                                          ),
                                        ),
                                        width: 148,
                                        height: 37,
                                        child: Center(
                                          child: Text(
                                            "CUT 20% TDS",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF60C3AD),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        // onPressed: () {},
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IdDetailsScreen(
                                                      reload: widget.reload,
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0XFF60C3AD),
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        width: 148,
                                        height: 37,
                                        child: Center(
                                          child: Text(
                                            "UPLOAD",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        // onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    // Icon(Icons.navigate_next)
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Offstage();
    }
  }
}
