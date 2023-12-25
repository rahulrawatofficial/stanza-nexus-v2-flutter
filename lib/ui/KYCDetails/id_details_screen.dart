import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/KYCDetails/upload_pan_image.dart';
import 'package:nexus_app/ui/KYCDetails/upload_pan_ad.dart';
import 'package:nexus_app/ui/Widgets/fill_details_note.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class IdDetailsScreen extends StatefulWidget {
  @required
  final Function reload;

  const IdDetailsScreen({Key key, this.reload}) : super(key: key);
  @override
  _IdDetailsScreenState createState() => _IdDetailsScreenState();
}

class _IdDetailsScreenState extends State<IdDetailsScreen> {
  bool sameName = false;
  var imageFile;
  bool loading = false;
  bool fieldsValid = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController panController = TextEditingController();
  String imageUrl;
  String panNumber;
  RegExp regExp = new RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  onSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        loading = true;
      });
      uploadPanDetails(context, imageFile, "${userData.mobileNumber}",
              nameController.text, panController.text, "${userData.partnerId}")
          .then((value) {
        setState(() {
          loading = false;
        });
        showToast("Pan Details Updated");
      });
    }
  }

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

  void _showBottomSheet(context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.image),
                title: new Text('Gallery'),
                onTap: () => getImageGallerySheet(context).then((value) {
                  Navigator.of(context).pop();
                  if (value != null) {
                    setState(() {
                      imageFile = value;
                      enabledDisabledButtonCondition();
                    });
                  }
                }),
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () => getImageCameraSheet(context).then((value) {
                  Navigator.of(context).pop();
                  if (value != null) {
                    setState(() {
                      imageFile = value;
                      enabledDisabledButtonCondition();
                    });
                  }
                }),
              ),
            ],
          );
        });
  }

  enabledDisabledButtonCondition() {
    if (imageFile != null &&
        nameController.text.length > 0 &&
        panController.text.length == 10 &&
        regExp.hasMatch(panController.text)) {
      setState(() {
        fieldsValid = true;
      });
    } else {
      setState(() {
        fieldsValid = false;
      });
    }
  }

  getIdDetails() {
    var param = {"partnerId": "${userData.partnerId}"};
    setState(() {
      loading = true;
    });
    ApiBase()
        .get(context, "/mlm-service/getPartnerKYCDetails", param, null)
        .then((value) {
      setState(() {
        loading = false;
      });
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.body != "") {
          var data = json.decode(value.body);
          setState(() {
            nameController.text = data["panName"];
            panController.text = data["panNumber"];
            imageUrl = data["panImage"];
            if (nameController.text.length > 0 &&
                panController.text.length == 10 &&
                regExp.hasMatch(data["panNumber"]) &&
                imageFile != null) {
              fieldsValid = true;
            }
          });
          print(data);
        }
      }
    });
  }

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {
        if (nameController.text == "${userData.name}") {
          sameName = true;
        } else {
          sameName = false;
        }
      });
      if (nameController.text.length > 0 &&
          panController.text.length == 10 &&
          imageFile != null) {
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
    // panController.addListener(() {
    //   if (nameController.text.length > 0 &&
    //       panNumber.length == 10 &&
    //       imageFile != null) {
    //     setState(() {
    //       fieldsValid = true;
    //     });
    //   } else {
    //     setState(() {
    //       fieldsValid = false;
    //     });
    //   }
    // });
    getIdDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ID Details"),
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Container(
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
                              "ID Details",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Upload your PAN card to be a verified partner and lower your TDS deductions.",
                              style: TextStyle(),
                            ),
                            SizedBox(
                              height: 25,
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
                                        sameName = _;
                                        if (_) {
                                          nameController.text =
                                              "${userData.name}";
                                        } else {
                                          nameController.text = "";
                                        }
                                      });
                                    },
                                    value: sameName,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Same as the registered name"),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "${userData.name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: "Name (as specified in the card)"),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: panController,
                              decoration:
                                  InputDecoration(hintText: "PAN Number"),
                              onChanged: (String newVal) {
                                if (newVal.length <= 10) {
                                  panNumber = newVal;
                                } else {
                                  panController.text = panNumber;
                                  panController.selection =
                                      new TextSelection.collapsed(
                                          offset: panNumber.length);
                                }
                                _formKey.currentState.validate();
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[A-Z0-9]')),
                              ],
                              validator: (value) {
                                // This is just a regular expression for email addresses
                                if (imageFile != null &&
                                    nameController.text.length > 0 &&
                                    value.length == 10 &&
                                    !regExp.hasMatch(value)) {
                                  return "Please enter a valid PAN card number";
                                }
                                enabledDisabledButtonCondition();
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                _formKey.currentState.validate();
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: imageFile != null
                                  ? Image.file(
                                      File(imageFile.path),
                                      height: 200,
                                      width: MediaQuery.of(context).size.width -
                                          32,
                                      fit: BoxFit.fill,
                                    )
                                  : imageUrl != null
                                      ? Image.network(
                                          imageUrl,
                                          height: 200,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              32,
                                          fit: BoxFit.fill,
                                        )
                                      : Offstage(),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  _showBottomSheet(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Color(0XFF60C3AD),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color: Color(0XFF4E5253),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 9.0,
                                        bottom: 9.0,
                                        left: 16.0,
                                        right: 16.0),
                                    child: imageFile != null || imageUrl != null
                                        ? Text(
                                            "RETAKE",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF4E5253),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        : Text(
                                            "UPLOAD",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF4E5253),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                  // onPressed: () {},
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
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
                              "SUBMIT",
                              style: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: fieldsValid
                                ? () {
                                    onSubmit();
                                  }
                                : null,
                            // onPressed: mobileController.text.length == 10 &&
                            //         !loading
                            //     ? () => onLogin()
                            //     : null,
                          ),
                        ),
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
              : Offstage(),
        ],
      ),
    );
  }
}
