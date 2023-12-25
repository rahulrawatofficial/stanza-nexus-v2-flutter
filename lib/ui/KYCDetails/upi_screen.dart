import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class UpiScreen extends StatefulWidget {
  final Function reload;

  const UpiScreen({Key key, this.reload}) : super(key: key);
  @override
  _UpiScreenState createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen> {
  bool loading = false;

  TextEditingController vpaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // On Confirm
  onConfirm() {
    // var param = {
    //   "partnerMobile": "${userData.mobileNumber}",
    // };
    var body = {
      "partnerId": "${userData.partnerId}",
      "payoutMode": {"name": "vpa", "payoutModeId": 3},
      "vpa": "${vpaController.text}",
      "partnerMobile": "${userData.mobileNumber}",
    };
    setState(() {
      loading = true;
    });
    ApiBase()
        .post(context, "/mlm-service/addPartnerUPIDetails", null, body, "")
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200) {
        showToast("UPI linked successfully");
      }
    });
  }

  getUpiDetails() {
    var param = {"partnerId": "${userData.partnerId}"};
    setState(() {
      loading = true;
    });
    ApiBase()
        .get(context, "/mlm-service/getPartnerUPIDetails", param, null)
        .then((value) {
      setState(() {
        loading = false;
      });
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.body != "") {
          var data = json.decode(value.body);
          setState(() {
            vpaController.text = data["vpa"];
          });
          print(data);
        }
      }
    });
  }

  bottomSheetButtonConfirm() {
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
                    "UPI Confirmation",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0XFF232728),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Please confirm that the following VPA needs to be added:",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${vpaController.text}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 24,
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
                              "CONFIRM UPI",
                              style: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              onConfirm();
                              // onVerifyBank().then((value) {});
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

  @override
  void initState() {
    getUpiDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPI"),
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
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add UPI Id",
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
                          "Add your existing Virtual Payment Address (VPA). \ne.g. username@bankname",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Enter VPA",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextFormField(
                          controller: vpaController,
                          decoration: InputDecoration(hintText: "Input Text"),
                          validator: (value) {
                            // This is just a regular expression for vpa addresses
                            String p = "[a-zA-Z0-9_]{3,}@[a-zA-Z0-9]{3,}";
                            RegExp regExp = new RegExp(p);

                            if (!regExp.hasMatch(value)) {
                              // So, the vpa is not valid
                              return "Please enter a valid VPA";
                            }

                            return null;
                          },
                          onEditingComplete: () {
                            _formKey.currentState.validate();
                          },
                        ),
                        SizedBox(
                          height: 40,
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
                                  // disabledColor: Color(0XFFA5A9A9),
                                  color: Color(0XFF31C8AE),
                                  child: Text(
                                    "Add VPA",
                                    style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      bottomSheetButtonConfirm();
                                    }
                                    // onAddVPA();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            "VPA details will be saved securely for future transactions.",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loading ? Center(child: CircularProgressIndicator()) : Offstage()
          ],
        ),
      ),
    );
  }
}
