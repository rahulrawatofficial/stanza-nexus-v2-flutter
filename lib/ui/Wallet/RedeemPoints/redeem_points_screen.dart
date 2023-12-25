import 'package:flutter/material.dart';
import 'package:nexus_app/model/kyc_detail_model.dart';
import 'package:nexus_app/model/redeem_tds_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Home/virtual_creditcard.dart';
import 'package:nexus_app/ui/Wallet/RedeemPoints/payout_sheet.dart';
import 'package:nexus_app/ui/Wallet/RedeemPoints/congratulations_screen.dart';
import 'package:nexus_app/ui/Wallet/RedeemPoints/payment_method_section.dart';
import 'package:nexus_app/ui/Wallet/RedeemPoints/points_converter.dart';
import 'package:nexus_app/ui/Widgets/appbar_points.dart';

class RedeemPointsScreen extends StatefulWidget {
  @override
  _RedeemPointsScreenState createState() => _RedeemPointsScreenState();
}

class _RedeemPointsScreenState extends State<RedeemPointsScreen> {
  String groupValue;
  int currentPoints;
  int currentAmount;
  bool loading = false;
  bool panVerified = false;

//on redeem points
  ongetTDSPoints() async {
    var params = {
      "amount": "$currentPoints",
      "brokerMobile": userData.mobileNumber,
    };
    setState(() {
      loading = true;
    });
    var response = await ApiBase()
        .get(context, "/mlm-service/getTdsDetailsForBroker", params, null);

    setState(() {
      loading = false;
    });
    if (response.statusCode == 200) {
      RedeemTdsModel data = redeemTdsModelFromJson(response.body);
      bottomSheetTdsBreakup(data);
    }
  }

  //on redeem points
  onRedeemPoints() async {
    var body = {
      "amountToRedeem": currentAmount,
      "brokerMobile": userData.mobileNumber,
      "partnerId": userData.partnerId,
      "paymentModeId": groupValue == "PAYTM"
          ? "1"
          : groupValue == "BANKTRANSFER"
              ? "2"
              : "3",
      "paymentModeName": groupValue,
      "pointsToRedeem": currentPoints
    };

    setState(() {
      loading = true;
    });
    var response = await ApiBase()
        .post(context, "/mlm-service/redeemPaymentBroker", null, body, null);

    setState(() {
      loading = false;
    });
    if (response.statusCode == 200) {
      print("Success");

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CongratulationsScreen(
                amount: currentAmount,
                points: currentPoints,
              )));
    }
  }

  reloadPage() {
    setState(() {});
  }

  bottomSheetTdsBreakup(RedeemTdsModel data) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            height: 499,
            decoration: BoxDecoration(
              color: Colors.white, // or some other color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: PayoutSheet(
              reloadPage: reloadPage,
              context: context,
              data: data,
              panVerified: panVerified,
              onPress: () {
                Navigator.of(context).pop();
                onRedeemPoints();
              },
            ),
          );
        });
  }

  Future<KycDetailModel> getPaymentDetails() async {
    var params = {"partnerId": "${userData.partnerId}"};

    final response = await ApiBase()
        .get(context, "/mlm-service/getPartnerKYCDetails", params, "");
    print(response.statusCode);

    if (response.statusCode == 200) {
      KycDetailModel data = kycDetailModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Points"),
        actions: [
          AppbarPoints(),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Card(
                          margin: EdgeInsets.all(0),
                          child: Column(
                            children: [
                              VCreditCard(
                                currentPoints: (value) {
                                  currentPoints = value;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0,
                                    bottom: 24.0,
                                    left: 16.0,
                                    right: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Redeem Points",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Enter the points you want to redeem",
                                      style: TextStyle(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    PointsConverter(
                                      pointValue: (val) {
                                        setState(() {
                                          currentPoints = val;
                                        });
                                      },
                                      amountValue: (val) {
                                        setState(() {
                                          currentAmount = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: getPaymentDetails(),
                            builder: (context,
                                AsyncSnapshot<KycDetailModel> snapshot) {
                              if (snapshot.hasData) {
                                return PaymentMethodSection(
                                  panVerified: (val) {
                                    panVerified = val;
                                  },
                                  reload: () {
                                    setState(() {});
                                  },
                                  kycData: snapshot.data,
                                  onChange: (value) {
                                    groupValue = value;
                                    print(value);
                                  },
                                );
                              } else {
                                return Offstage();
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                disabledColor: Color(0XFFA5A9A9),
                                color: Color(0XFF31C8AE),
                                child: Text(
                                  "REDEEM VIA CASH",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: !loading &&
                                        currentPoints != null &&
                                        groupValue != null
                                    ? () {
                                        ongetTDSPoints();
                                      }
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
    );
  }
}
