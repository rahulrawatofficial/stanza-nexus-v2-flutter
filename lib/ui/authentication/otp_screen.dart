import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/user_data_model.dart';
import 'package:nexus_app/resources/local_data.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/authentication/PinView/pin_view.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/ui/bottom_navigation.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({Key key, @required this.mobileNumber}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool loading = false;
  bool clearAll = false;
  String otp = "";
  bool isOTPNotValid = false;

  // On Pressing Verify
  onVerify() {
    var body = {
      "isoCode": "IN",
      "mobile": widget.mobileNumber,
      // "otpType": "LOGIN",
      "userType": "EXTERNAL",
      "otp": otp,
    };
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/internal/validateOtp", null, body, "")
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {
        UserDataModel data = userDataModelFromJson(value.body);
        userData = data;
        // userUuid = data["partnerId"];
        // userReferralCode = data["referralCode"];
        // userMobileNumber = widget.mobileNumber;
        // userName = data["name"];
        // if (data["message"] == "OTP Succefully Validated") {
        saveLogin(data).then((value) => Navigator.of(context)
            .pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeNavigationBar()),
                ModalRoute.withName('/')));
        // } else {
        //   Fluttertoast.showToast(
        //     msg: "OTP you've entered is incorrect. Please try again!",
        //     fontSize: 14.0,
        //   );
        //   // ErrorAlert()
        //   //     .showErrorDailog(context, "", data["message"], null, false);
        // }
      } else {
        setState(() {
          isOTPNotValid = true;
        });
      }
    });
  }

  // Resend Send Otp
  resendOtp() {
    var body = {
      "isoCode": "IN",
      "mobile": widget.mobileNumber,
      "userType": "EXTERNAL"
    };
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/internal/resendOtp", null, body, "")
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "OTP Verification",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "We have sent the 4-digit code to \n +91-${widget.mobileNumber}.",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                         width: 300,
                        child: PinView(
                          clearAll: clearAll,
                          currentValue: (v) {
                            print(v.length);
                            print(v);
                            setState(() {
                              isOTPNotValid = false;
                              otp = v;
                              clearAll = false;
                            });
                          },
                          submit: (pin) {
                              isOTPNotValid = false;
                            print(pin);
                            onVerify();
                          },
                          count: 4,
                        ),
                      ),
                      Visibility(
                        visible: isOTPNotValid == true ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "OTP you've entered is incorrect. Please try again!",
                            style: TextStyle(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn’t receive the OTP?",
                            style: TextStyle(fontSize: 14),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: Color(0XFF31C8AE),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isOTPNotValid = false;
                                otp = "";
                                clearAll = true;
                              });
                              resendOtp();
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                color: otp.length == 4
                                    ? Color(0XFF31C8AE)
                                    : Color(0XFFA5A9A9),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: otp.length == 4 && !loading
                                    ? () => {isOTPNotValid = false, onVerify()}
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
