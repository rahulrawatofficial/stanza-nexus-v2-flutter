import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/model/city_locality_model.dart';
import 'package:nexus_app/model/signup_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:nexus_app/ui/authentication/login_screen.dart';
import 'package:nexus_app/ui/authentication/signup_otp_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  bool fieldsValid = false;
  bool userNameExist = false;
  bool referralValid;

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Text Editing Controllers

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  List<CityLocalityModel> cityList = [];
  List cityNameList = [];
  String currentCity;
  int cityIndex;

  //On CheckUsername
  Future checkUserName() async {
    var param = {"username": userNameController.text};
    ApiBase()
        .get(context, "/mlm-service/internal/checkUsernameExist", param, null)
        .then((value) {
      // setState(() {
      //   loading = false;
      // });
      print(value.statusCode);
      if (value.statusCode == 409) {
        setState(() {
          userNameExist = true;
        });
      } else {
        setState(() {
          userNameExist = false;
        });
      }
    });
  }

  //On Check Referral
  Future<bool> checkReferral() async {
    setState(() {
      loading = true;
    });
    var param = {"referralCode": referralController.text};
    var response = await ApiBase().get(
        context, "/mlm-service/internal/validateReferralCode", param, null);
    setState(() {
      loading = false;
    });
    if (response.statusCode == 200) {
      if (response.body == "") {
        referralValid = false;
        return false;
      } else {
        referralValid = true;
        return true;
      }
    } else {
      referralValid = false;
      return false;
    }
  }

  onSignUp() {
    SignupModel body = SignupModel(
      city: cityNameList[cityIndex],
      cityId: cityList[cityIndex].cityId,
      email: emailController.text,
      mobileNumber: mobileController.text,
      name: nameController.text,
      // "partnerId": "string",
      referredBy: referralController.text,
      username: userNameController.text,
    );
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/internal/signUpUser", null, body, null)
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {
        var data = json.decode(value.body);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignupOtpScreen(
                  mobileNumber: mobileController.text,
                  dataId: data["data"],
                  signupModel: body,
                )));
      }
    });
  }

  //On Validate
  void _validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (referralController.text.length == 0) {
        setState(() {
          loading = true;
        });
        var params = {"mobileNumber": mobileController.text};
        ApiBase()
            .get(context, "/mlm-service/internal/checkPartnerExistByMobile",
                params, null)
            .then((valueM) {
          setState(() {
            loading = false;
          });
          print(valueM.body);
          if (valueM.statusCode == 200) {
            if (valueM.body == "") {
              onSignUp();
            } else {
              showToast("Mobile number already exist");
            }
          }
        });
      } else {
        checkReferral().then((refValue) {
          if (refValue) {
            setState(() {
              loading = true;
            });
            var params = {"mobileNumber": mobileController.text};
            ApiBase()
                .get(context, "/mlm-service/internal/checkPartnerExistByMobile",
                    params, null)
                .then((valueM) {
              setState(() {
                loading = false;
              });
              if (valueM.statusCode == 200) {
                if (valueM.body == "") {
                  onSignUp();
                } else {
                  showToast("Mobile number already exist");
                }
              }
            });
          }
        });
      }
    }
  }

  //Adding listner
  textFieldListner() {
    //Listener
    nameController.addListener(() {
      if (nameController.text.length > 0 &&
          mobileController.text.length == 10 &&
          userNameController.text.length > 0 &&
          !userNameExist) {
        setState(() {
          fieldsValid = true;
        });
      } else {
        setState(() {
          fieldsValid = false;
        });
      }
    });
    //Listener
    mobileController.addListener(() {
      if (nameController.text.length > 0 &&
          mobileController.text.length == 10 &&
          userNameController.text.length > 0 &&
          !userNameExist) {
        setState(() {
          fieldsValid = true;
        });
      } else {
        setState(() {
          fieldsValid = false;
        });
      }
    });
    //Listener
    userNameController.addListener(() {
      checkUserName().then((value) {
        if (nameController.text.length > 0 &&
            mobileController.text.length == 10 &&
            userNameController.text.length > 0 &&
            !userNameExist) {
          setState(() {
            fieldsValid = true;
          });
        } else {
          setState(() {
            fieldsValid = false;
          });
        }
      });
    });
  }

  void changedDropDownItemCity(String selectedCity) {
    cityIndex = cityNameList.indexOf(selectedCity);
    print(cityIndex);
    setState(() {
      currentCity = selectedCity;
    });
  }

  @override
  void initState() {
    textFieldListner();
    ApiBase()
        .get(context, "/mlm-service/internal/getCityAndLocality", null, null)
        .then((value) {
      if (value.statusCode == 200) {
        cityList = cityLocalityModelFromJson(value.body);
        setState(() {
          for (int i = 0; i < cityList.length; i++) {
            cityNameList.add(cityList[i].name);
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up",
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
                        "Enter your information below to continue",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name*",
                          labelStyle: TextStyle(
                            color: Color(0XFF232728),
                          ),
                        ),
                        validator: (value) {
                          if (value.length == 0) {
                            return ("Please enter the full name");
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          labelText: "Username*",
                          labelStyle: TextStyle(
                            color: Color(0XFF232728),
                          ),
                          suffixIcon: userNameController.text.length == 0
                              ? Offstage()
                              : userNameExist
                                  ? Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.lightGreen,
                                    ),
                        ),
                        validator: (value) {
                          if (value.length == 0) {
                            return ("Please enter the user name");
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // Text(
                      //   "Mobile Number",
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: "Mobile Number*",
                          labelStyle: TextStyle(
                            color: Color(0XFF232728),
                          ),
                          prefixText: "+91 | ",
                          prefixStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value.length != 10) {
                            return ("Please enter a 10-digit number only");
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email*",
                          labelStyle: TextStyle(
                            color: Color(0XFF232728),
                          ),
                        ),
                        validator: (value) {
                          if (!isValidEmail(value)) {
                            return ("Please enter valid email");
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "City*",
                          labelStyle: TextStyle(
                            color: Color(0XFF232728),
                          ),
                        ),
                        items: getDropDownMenuItems(cityNameList),
                        onChanged: changedDropDownItemCity,
                        value: currentCity,
                        validator: (value) {
                          if (value == null) {
                            return ("Please select the city of the lead");
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: referralController,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () {
                              checkReferral();
                            },
                            child: Text(
                              "APPLY",
                              style: TextStyle(
                                // fontSize: 20,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          labelText: "Enter Referral Code (optional)",
                          labelStyle: TextStyle(
                            color: Color(0XFF232728),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      referralValid == null || referralController.text == ""
                          ? Offstage()
                          : referralValid
                              ? Text(
                                  "Referral code is valid",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  "Referral code is invalid. Please either enter the correct code or remove it.",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                      SizedBox(
                        height: 40,
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
                                color: fieldsValid
                                    ? Color(0XFF31C8AE)
                                    : Color(0XFFA5A9A9),
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  _validate();
                                },
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
                              "Already have an account?  ",
                              style: TextStyle(fontSize: 14),
                            ),
                            InkWell(
                              child: Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            loading ? Center(child: CircularProgressIndicator()) : Offstage()
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
