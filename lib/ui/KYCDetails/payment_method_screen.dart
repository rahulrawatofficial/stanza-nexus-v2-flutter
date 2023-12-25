import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/KYCDetails/bank_account_screen.dart';
import 'package:nexus_app/ui/KYCDetails/payment_method_tiles.dart';
import 'package:nexus_app/ui/KYCDetails/paytm_screen.dart';
import 'package:nexus_app/ui/KYCDetails/upi_screen.dart';
import 'package:nexus_app/ui/Widgets/fill_details_note.dart';

class PaymentMethodScreen extends StatefulWidget {
  final Function reload;

  const PaymentMethodScreen({Key key, this.reload}) : super(key: key);
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
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

  reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        centerTitle: true,
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
            future: getPaymentDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: DataTiles(
                      snapshot: snapshot,
                      refresh: reloadPage,
                    ),
                  );
                } else {
                  //Show error here
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                //Show progress
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // if (snapshot.hasData) {
              //   print("yes");
              //   return DataTiles(
              //     snapshot: snapshot,
              //   );
              // } else {
              //   print("NO");
              //   return NoDataTiles();
              // }
            }),
      ),
    );
  }
}

class NoDataTiles extends StatefulWidget {
  const NoDataTiles({
    Key key,
  }) : super(key: key);

  @override
  _NoDataTilesState createState() => _NoDataTilesState();
}

class _NoDataTilesState extends State<NoDataTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.0,
          ),
          FillDetailsNote(),
          SizedBox(
            height: 24,
          ),
          Text(
            "Payment Method",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Add atleast one of your payment method to ensure that you receive the referral amount.",
            style: TextStyle(),
          ),
          SizedBox(
            height: 25,
          ),
          PaymentMethodTile(
            color: Color(0XFFF6F4F5),
            title: "Paytm",
            subTitle:
                "Enter your KYC verified paytm number to receive the earnings",
            iconAsset: "assets/paytm.png",
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PaytmScreen()));
            },
          ),
          PaymentMethodTile(
            color: Color(0XFFF6F4F5),
            title: "Bank Account",
            subTitle:
                "Enter bank details and get it verified to receive the earnings",
            iconAsset: "assets/bank.png",
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BankAccountScreen()));
            },
          ),
          PaymentMethodTile(
            color: Color(0XFFF6F4F5),
            title: "UPI",
            subTitle: "Enter your registered UPI ID to receive the earnings",
            iconAsset: "assets/upi.png",
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UpiScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class DataTiles extends StatefulWidget {
  @required
  final Function refresh;
  final snapshot;
  const DataTiles({
    Key key,
    this.snapshot,
    this.refresh,
    // this.modeId,
  }) : super(key: key);

  @override
  _DataTilesState createState() => _DataTilesState();
}

class _DataTilesState extends State<DataTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.0,
          ),
          FillDetailsNote(),
          SizedBox(
            height: 24,
          ),
          Text(
            "Payment Method",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Add atleast one of your payment method to ensure that you receive the referral amount.",
            style: TextStyle(),
          ),
          SizedBox(
            height: 25,
          ),
          widget.snapshot.data["paytmNumber"] == null
              ? PaymentMethodTile(
                  color: Color(0XFFF6F4F5),
                  title: "Paytm",
                  subTitle:
                      "Enter your KYC verified paytm number to receive the earnings",
                  iconAsset: "assets/paytm.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaytmScreen(
                              reload: widget.refresh,
                            )));
                  },
                )
              : PaymentMethodTileFilled(
                  preferred:
                      widget.snapshot.data["preferredPaymentMode"] == "PAYTM"
                          ? true
                          : false,
                  color: Color(0XFFF6F4F5),
                  title: "Paytm",
                  subTitle: "${widget.snapshot.data["paytmNumber"]}",
                  iconAsset: "assets/paytm.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaytmScreen(
                              reload: widget.refresh,
                            )));
                  },
                  modeId: "1",
                  refresh: widget.refresh,
                ),
          widget.snapshot.data["accountNumber"] == null
              ? PaymentMethodTile(
                  color: Color(0XFFF6F4F5),
                  title: "Bank Account",
                  subTitle:
                      "Enter bank details and get it verified to receive the earnings",
                  iconAsset: "assets/bank.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BankAccountScreen(
                              reload: widget.refresh,
                            )));
                  },
                )
              : PaymentMethodTileFilled(
                  preferred: widget.snapshot.data["preferredPaymentMode"] ==
                          "BANKTRANSFER"
                      ? true
                      : false,
                  color: Color(0XFFF6F4F5),
                  title: "Bank Account",
                  subTitle: "${widget.snapshot.data["accountNumber"]}",
                  iconAsset: "assets/bank.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BankAccountScreen(
                              reload: widget.refresh,
                            )));
                  },
                  modeId: "2",
                  refresh: widget.refresh,
                ),
          widget.snapshot.data["vpaAddress"] == null
              ? PaymentMethodTile(
                  color: Color(0XFFF6F4F5),
                  title: "UPI",
                  subTitle:
                      "Enter your registered UPI ID to receive the earnings",
                  iconAsset: "assets/upi.png",
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => UpiScreen(
                                  reload: widget.refresh,
                                )))
                        .then((value) {});
                  },
                )
              : PaymentMethodTileFilled(
                  preferred:
                      widget.snapshot.data["preferredPaymentMode"] == "VPA"
                          ? true
                          : false,
                  color: Color(0XFFF6F4F5),
                  title: "UPI",
                  subTitle: "${widget.snapshot.data["vpaAddress"]}",
                  iconAsset: "assets/upi.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpiScreen(
                              reload: widget.refresh,
                            )));
                  },
                  modeId: "3",
                  refresh: widget.refresh,
                ),
        ],
      ),
    );
  }
}
