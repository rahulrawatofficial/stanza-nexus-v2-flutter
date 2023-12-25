import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/tds_info_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/KYCDetails/id_details_screen.dart';
import 'package:nexus_app/ui/KYCDetails/kyc_screen_widgets.dart';
import 'package:nexus_app/ui/KYCDetails/payment_method_screen.dart';
import 'package:nexus_app/ui/KYCDetails/tds_tile.dart';
import 'package:nexus_app/ui/Widgets/appbar_points.dart';
import 'package:nexus_app/ui/Widgets/fill_details_note.dart';

class KycDetailsScreen extends StatefulWidget {
  final Function reload;

  const KycDetailsScreen({Key key, @required this.reload}) : super(key: key);
  @override
  _KycDetailsScreenState createState() => _KycDetailsScreenState();
}

class _KycDetailsScreenState extends State<KycDetailsScreen> {
  bool loading = false;
  TdsInfo tdsInfo;
  bottomSheetButtonTds(String data) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            height: 340,
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
                    "Payouts",
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
                    data,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getTdsDeductionMessage() {
    var param = {"type": "PAYOUT"};
    ApiBase()
        .get(context, "/mlm-service/getTdsDeductionMessage", param, null)
        .then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.body != "") {
          bottomSheetButtonTds(value.body);
        }
      }
    });
  }

  Future getPaymentDetails() async {
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

  Future getTdsInfo() async {
    ApiBase().get(context, "/mlm-service/getTdsInfo", null, null).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.body != "") {
          var data = json.decode(value.body);
          tdsInfo = TdsInfo.fromJson(data);
          return data;
        } else {
          return null;
        }
      }
    });
  }

  reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KYC Details"),
        centerTitle: true,
        actions: [
          AppbarPoints(),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            size: 40,
          ),
          onPressed: () {
            widget.reload();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: FutureBuilder(
            future: Future.wait([getPaymentDetails(), getTdsInfo()]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.0,
                        ),
                        Stack(
                          children: [
                            FillDetailsNote(),
                            Positioned(
                              top: 36,
                              right: 16,
                              child: InkWell(
                                onTap: () async {
                                  await getTdsDeductionMessage();
                                },
                                child: Text(
                                  "Learn More",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "KYC",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Complete the details to ensure that you receive the referral amount.",
                          style: TextStyle(),
                        ),
                        KYCTile(
                            color: Color(0XFFEDF4FF),
                            title: "ID Details",
                            subTitle:
                                "Upload PAN card to be a verified partner and lower your TDS",
                            iconAsset: "assets/id.png",
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => IdDetailsScreen(
                                        reload: reloadPage,
                                      )));
                            },
                            extraData: snapshot.data[0]["panName"] != null
                                ? PanContent(
                                    panName: snapshot.data[0]["panName"],
                                    panNumber: snapshot.data[0]["panNumber"],
                                  )
                                : null),
                        KYCTile(
                          color: Color(0XFFF6F4F5),
                          title: "Payment Method",
                          subTitle:
                              "Add payment details to ensure that you receive the referral amount.",
                          iconAsset: "assets/payment_method.png",
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentMethodScreen(
                                      reload: reloadPage,
                                    )));
                          },
                          extraData: PaymentContent(
                            paytmNumber: snapshot.data[0]["paytmNumber"],
                            bankAccount: snapshot.data[0]["accountNumber"],
                            vpa: snapshot.data[0]["vpaAddress"],
                          ),
                        ),
                        snapshot.data[0]["maxTds"] ||
                                snapshot.data[0]["panNumber"] != null
                            ? Offstage()
                            : TdsTile(reload: reloadPage, data: tdsInfo),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
