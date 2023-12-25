import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:nexus_app/ui/authentication/PinView/pin_view.dart';

class PaytmOtpScreen extends StatefulWidget {
  final String mobileNumber;

  const PaytmOtpScreen({Key key, @required this.mobileNumber})
      : super(key: key);
  @override
  _PaytmOtpScreenState createState() => _PaytmOtpScreenState();
}

class _PaytmOtpScreenState extends State<PaytmOtpScreen> {
  bool loading = false;
  bool clearAll = false;
  String otp = "";

  // On Pressing Verify
  onVerify() {
    var body = {
      "partnerId": "${userData.partnerId}",
      "partnerMobile": "${userData.mobileNumber}",
      "payoutMode": {"name": "paytm", "payoutModeId": 1},
      "paytmNumber": widget.mobileNumber,
      "validationKey": "$otp"
    };
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/validatePaytmOtp", null, body, "")
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {
        Navigator.of(context).pop();

        showToast("Paytm linked successfully");
      }
    });
  }

  // Resend Send Otp
  resendOtp() {
    var body = {
      "partnerId": "${userData.partnerId}",
      "partnerMobile": "${userData.mobileNumber}",
      "payoutMode": {"name": "paytm", "payoutModeId": 1},
      "paytmNumber": widget.mobileNumber,
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
                  width: 216,
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
                        "We have sent the 4-digit code to +91-${widget.mobileNumber}.",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        // width: 300,
                        child: PinView(
                          clearAll: clearAll,
                          currentValue: (v) {
                            print(v.length);
                            print(v);
                            setState(() {
                              otp = v;
                              clearAll = false;
                            });
                          },
                          submit: (pin) {
                            print(pin);
                            onVerify();
                          },
                          count: 4,
                        ),
                      )
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
                                  // color: Color(0XFF31C8AE),
                                  ),
                            ),
                            onPressed: () {
                              setState(() {
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
                                    ? () => onVerify()
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
