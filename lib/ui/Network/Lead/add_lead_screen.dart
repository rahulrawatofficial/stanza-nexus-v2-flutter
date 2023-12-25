import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/model/city_locality_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Lead/select_gender_widget.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class AddLeadScreen extends StatefulWidget {
  @override
  _AddLeadScreenState createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  bool loading = false;
  bool fieldsValid = false;
  // bool userNameExist = false;
  bool referralValid;
  String gender;

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Text Editing Controllers

  TextEditingController firstNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  List<CityLocalityModel> cityList = [];
  List cityNameList = [];
  String currentCity;
  int cityIndex;

  List<MicroMarket> localityList = [];
  List localityNameList = [];
  String currentLocality;
  int localityIndex;

  onAddingLead() {
    var param = {"brokerMobile": userData.mobileNumber};
    var body = {
      "cityId": cityList[cityIndex].cityId,
      "email": emailController.text,
      "firstName": firstNameController.text,
      "gender": gender,
      "lastName": lastNameController.text,
      "localityId": localityList[localityIndex].id,
      "mobile": mobileController.text,
    };
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/createLead", param, body, null)
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {
        var data = json.decode(value.body);
        showToast("Lead created successfully!");
        Navigator.of(context).pop();
      }
    });
  }

  //On Validate
  void _validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
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
            onAddingLead();
          } else {
            showToast("Mobile number already exist");
          }
        }
      });
    }
  }

  //ValidationCheck
  validationCheck() {
    if (firstNameController.text.length > 0 &&
        mobileController.text.length == 10 &&
        lastNameController.text.length > 0 &&
        currentCity != null &&
        currentLocality != null &&
        gender != null) {
      setState(() {
        fieldsValid = true;
      });
    } else {
      setState(() {
        fieldsValid = false;
      });
    }
  }

  //Adding listner
  textFieldListner() {
    // Listener
    firstNameController.addListener(() {
      validationCheck();
    });
    //Listener
    mobileController.addListener(() {
      validationCheck();
    });
    //Listener
    lastNameController.addListener(() {
      validationCheck();
    });
  }

  void changedDropDownItemCity(String selectedCity) {
    cityIndex = cityNameList.indexOf(selectedCity);
    print(cityIndex);
    setState(() {
      currentCity = selectedCity;
    });
    localityList.clear();
    localityNameList.clear();
    setState(() {
      for (int i = 0; i < cityList[cityIndex].microMarket.length; i++) {
        localityList.add(cityList[cityIndex].microMarket[i]);
        localityNameList.add(cityList[cityIndex].microMarket[i].name);
        currentLocality = null;
      }
    });

    validationCheck();
  }

  void changedDropDownItemLocality(String selectedLocality) {
    localityIndex = localityNameList.indexOf(selectedLocality);
    print(localityIndex);
    setState(() {
      currentLocality = selectedLocality;
    });

    validationCheck();
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
      appBar: AppBar(
        title: Text("Create Lead"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Referral",
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
                              "Please fill in the following details to submit the lead.",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ), // Text(
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
                              controller: firstNameController,
                              decoration: InputDecoration(
                                labelText: "First Name*",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              validator: (value) {
                                if (value.length == 0) {
                                  return ("Please enter the first name");
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                labelText: "Last Name*",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              validator: (value) {
                                if (value.length == 0) {
                                  return ("Please enter the last name");
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
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return ("Please enter the email");
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
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Locality*",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              items: getDropDownMenuItems(localityNameList),
                              onChanged: changedDropDownItemLocality,
                              value: currentLocality,
                              validator: (value) {
                                if (value == null) {
                                  return ("Please select the locality of the lead");
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SelectGenderWidget(
                              currentGender: gender,
                              genderChange: (cg) {
                                print(cg);
                                setState(() {
                                  gender = cg;
                                });

                                validationCheck();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                            "SUBMIT",
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
              ],
            ),
            loading ? Center(child: CircularProgressIndicator()) : Offstage()
          ],
        ),
      ),
    );
  }
}
