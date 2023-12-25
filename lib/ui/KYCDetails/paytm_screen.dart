import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/ui/KYCDetails/paytm_otp_screen.dart';
import 'package:nexus_app/resources/variables.dart';

class PaytmScreen extends StatefulWidget {
  final Function reload;

  const PaytmScreen({Key key, this.reload}) : super(key: key);
  @override
  _PaytmScreenState createState() => _PaytmScreenState();
}

class _PaytmScreenState extends State<PaytmScreen> {
  bool loading = false;
  bool sameNumber = false;

  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    //Listener
    mobileController.addListener(() {
      setState(() {
        if (mobileController.text == "${userData.mobileNumber}") {
          sameNumber = true;
        } else {
          sameNumber = false;
        }
      });
    });
    getPaytmDetails();
    super.initState();
  }

  // On Pressing Send Otp
  onSendOtp() {
    var body = {
      "partnerId": "${userData.partnerId}",
      "partnerMobile": "${userData.mobileNumber}",
      "payoutMode": {"name": "paytm", "payoutModeId": 1},
      "paytmNumber": mobileController.text,
      // "validationKey": "string"
    };
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/sendPaytmVerificationOtpRequest", null,
            body, "")
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PaytmOtpScreen(
                  mobileNumber: mobileController.text,
                )));
      }
    });
  }

  getPaytmDetails() {
    var param = {"partnerId": "${userData.partnerId}"};
    setState(() {
      loading = true;
    });
    ApiBase()
        .get(context, "/mlm-service/getPartnerPaytmDetails", param, null)
        .then((value) {
      setState(() {
        loading = false;
      });
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.body != "") {
          var data = json.decode(value.body);
          setState(() {
            mobileController.text = data["mobileNumber"];
          });
          print(data);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paytm"),
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
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Link Paytm Wallet",
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
                        "Linking wallet is a one-time process. Please add a KYC approved Paytm number below",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Mobile Number",
                        style: TextStyle(fontSize: 14),
                      ),
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          prefixText: "+91 | ",
                          prefixStyle: TextStyle(
                            // color: Colors.black,
                            fontSize: 16,
                          ),
                          // suffix: mobileController.text.length > 0
                          //     ? IconButton(
                          //         icon: Icon(
                          //           Icons.cancel,
                          //           color: Colors.red,
                          //           size: 20,
                          //         ),
                          //         onPressed: () {
                          //           setState(() {
                          //             mobileController.clear();
                          //           });
                          //         },
                          //       )
                          //     : null,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                              onChanged: (_) {
                                setState(() {
                                  sameNumber = _;
                                  if (sameNumber) {
                                    mobileController.text =
                                        "${userData.mobileNumber}";
                                  } else {
                                    mobileController.text = "";
                                  }
                                });
                              },
                              value: sameNumber,
                              // activeColor: Color(0XFF7A7D7E),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Same as the registered number"),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "+91-${userData.mobileNumber}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                                  "SEND OTP",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: mobileController.text.length == 10 &&
                                        !loading
                                    ? () => onSendOtp()
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
            loading ? Center(child: CircularProgressIndicator()) : Offstage()
          ],
        ),
      ),
    );
  }
}
