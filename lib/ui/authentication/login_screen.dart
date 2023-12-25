import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/show_alert.dart';
import 'package:nexus_app/ui/authentication/otp_screen.dart';
import 'package:nexus_app/ui/authentication/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  bool isUserNotExist = false;

  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    //Listener
    mobileController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // On Pressing Send Otp
  onLogin() {
    var body = {
      "isoCode": "IN",
      "mobile": mobileController.text,
      // "otpType": "LOGIN",
      "userType": "EXTERNAL"
    };
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/internal/login", null, body, "")
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {
        print("##${value.headers}##");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              mobileNumber: mobileController.text,
            ),
          ),
        );
      } else {
        // CustAlert().showAlrtDailog(
        //     context,
        //     "",
        //     "Phone number entered doesn’t  exist in the system. Please either login with the correct number or sign up.",
        //     null,
        //     "Ok");
        setState(() {
          isUserNotExist = true;
        });
      }
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
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
                        "Enter your phone number to proceed",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Text(
                      //   "Mobile Number",
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      TextFormField(
                        autofocus: true,
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: isUserNotExist
                            ? TextStyle(color: Colors.red)
                            : TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixText: "+91 | ",
                          labelStyle: TextStyle(height: 0),
                          labelText: "Mobile Number",
                          hintText: "Mobile Number",
                          errorText: isUserNotExist &&
                                  mobileController.text.length == 10
                              ? "You have entered invalid mobile number"
                              : isUserNotExist &&
                                      mobileController.text.length != 10
                                  ? "Please enter a 10-digit mobile number"
                                  : null,
                          errorStyle: TextStyle(
                            color: isUserNotExist ? Colors.red : Colors.black,
                          ),
                          prefixStyle: TextStyle(
                            color: isUserNotExist ? Colors.red : Colors.black,
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
                        onChanged: (text) {
                          if (isUserNotExist == true) {
                            setState(() {
                              isUserNotExist = false;
                            });
                          }
                        },
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
                                color: mobileController.text.length == 10 &&
                                        !loading
                                    ? Color(0XFF31C8AE)
                                    : Color(0XFFA5A9A9),
                                child: Text(
                                  "SEND OTP",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () => {
                                  isUserNotExist = false,
                                  if (mobileController.text.length == 10)
                                    {onLogin()}
                                  else
                                    {
                                      setState(() {
                                        isUserNotExist = true;
                                      }),
                                    }
                                },
                                // onPressed: mobileController.text.length == 10 &&
                                //         !loading
                                //     ? () => {isUserNotExist = false, onLogin()}
                                //     : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account yet?  ",
                              style: TextStyle(fontSize: 14),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
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
