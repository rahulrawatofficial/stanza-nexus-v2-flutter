import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:nexus_app/resources/show_alert.dart';

class BankAccountScreen extends StatefulWidget {
  final Function reload;

  const BankAccountScreen({Key key, this.reload}) : super(key: key);
  @override
  _BankAccountScreenState createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  TextEditingController bNameController = TextEditingController();
  TextEditingController accNoController = TextEditingController();
  TextEditingController reAccNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  double verifyAmount = 0;

  // On Pressing Verify
  Future onVerifyBank() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var body = {
        "accountNumber": accNoController.text,
        "beneficiaryName": bNameController.text,
        "brokerMobile": "${userData.mobileNumber}",
        "ifscCode": ifscController.text,
        "partnerId": "${userData.partnerId}",
        // "amount": double.parse(amountController.text),
        // "verifiedStatus": true
      };
      setState(() {
        loading = true;
      });
      ApiBase()
          .post(context, "/mlm-service/sendPennyForBankAccountVerification",
              null, body, "")
          .then((value) {
        setState(() {
          loading = false;
        });
        if (value.statusCode == 200) {
          var data = json.decode(value.body);
          verifyAmount = data["amount"];
          if (verifyAmount == null) {
            showAlertDialog(context, data["message"]);
          } else {
            showBottonSheetField();
          }
        } else {
          print(value.body);
          var data = json.decode(value.body);
          showAlertDialog(context, data["message"]);
        }
      });
    }
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // On Pressing Verify
  Future onSendAmount() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var body = {
        "accountNumber": accNoController.text,
        "beneficiaryName": bNameController.text,
        "brokerMobile": "${userData.mobileNumber}",
        "ifscCode": ifscController.text,
        "partnerId": "${userData.partnerId}",
        "amount": double.parse(amountController.text),
        // "verifiedStatus": true
      };
      setState(() {
        loading = true;
      });
      ApiBase()
          .post(context, "/mlm-service/validateAndStorePartnerBankDetails",
              null, body, "")
          .then((value) {
        setState(() {
          loading = false;
        });
        if (value.statusCode == 200) {
          // Navigator.of(context).pop();
          showToast("Bank Account Details Saved");
        }
      });
    }
  }

  bottomSheetButton() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            height: 272,
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
                  Text(
                    "Add Bank Account",
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
                    "Please enter your bank details to complete KYC. Earnings will be automatically credited on your account post approval",
                    style: TextStyle(
                      fontSize: 14,
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
                            disabledColor: Color(0XFFA5A9A9),
                            color: Color(0XFF31C8AE),
                            child: Text(
                              "VERIFY BANK ACCOUNT",
                              style: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              onVerifyBank().then((value) {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  showBottonSheetField() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Form(
            key: _formKey2,
            //child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
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
                    Text(
                      "Verify Bank Account Details",
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
                      "We have deposited a nominal amount in\nA/C No: ${accNoController.text}. Please enter the received amount ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: "Enter Amount",
                        ),
                        validator: (value) {
                          if (value.length > 0) {
                            if (double.parse(value) == verifyAmount) {
                              return null;
                            } else {
                              return "Please enter the correct amount";
                            }
                          } else {
                            return null;
                          }
                        },
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
                              disabledColor: Color(0XFFA5A9A9),
                              color: Color(0XFF31C8AE),
                              child: Text(
                                "VERIFY BANK ACCOUNT",
                                style: TextStyle(
                                  color: Color(0XFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey2.currentState.validate()) {
                                  Navigator.of(context).pop();
                                  onSendAmount();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //),
          );
        });
  }

  getBankDetails() {
    var param = {"partnerId": "${userData.partnerId}"};
    setState(() {
      loading = true;
    });
    ApiBase()
        .get(context, "/mlm-service/getPartnerBankDetails", param, null)
        .then((value) {
      setState(() {
        loading = false;
      });
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.body != "") {
          var data = json.decode(value.body);
          setState(() {
            bNameController.text = data["beneficiaryName"];
            accNoController.text = data["accountNumber"];
            reAccNoController.text = data["accountNumber"];
            ifscController.text = data["ifscCode"];
          });
          print(data);
        } else {
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    getBankDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Account"),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Bank Account",
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
                              "Please enter your bank details to complete KYC. Earnings will be automatically credited on your account post approval",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            // Text(
                            //   "Beneficiary Name",
                            //   style: TextStyle(fontSize: 14),
                            // ),
                            TextFormField(
                              controller: bNameController,
                              decoration: InputDecoration(
                                labelText: "Beneficiary Name",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              validator: (value) {
                                if (value.length == 0) {
                                  return ("Please enter the beneficiary name");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: accNoController,
                              decoration: InputDecoration(
                                labelText: "Account Number",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              validator: (value) {
                                if (value.length == 0) {
                                  return ("Please enter the bank account number");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: reAccNoController,
                              decoration: InputDecoration(
                                labelText: "Re-enter Account Number",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              validator: (value) {
                                if (reAccNoController.text !=
                                    accNoController.text) {
                                  return ("Account numbers should match");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z0-9]')),
                              ],
                              controller: ifscController,
                              decoration: InputDecoration(
                                labelText: "IFSC Code",
                                labelStyle: TextStyle(
                                  color: Color(0XFF232728),
                                ),
                              ),
                              validator: (value) {
                                if (value.length == 0) {
                                  return ("Please enter the correct IFSC code");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
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
                                  "VERIFY BANK ACCOUNT",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: bNameController.text.length > 0 &&
                                        reAccNoController.text.length > 0 &&
                                        ifscController.text.length > 0 &&
                                        accNoController.text.length > 0
                                    ? () => {
                                          if (_formKey.currentState.validate())
                                            {bottomSheetButton()}
                                        }
                                    : null,
                                // onPressed: () {
                                //   // onVerify();
                                //   if (_formKey.currentState.validate()) {
                                //     bottomSheetButton();
                                //   }
                                // },
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
