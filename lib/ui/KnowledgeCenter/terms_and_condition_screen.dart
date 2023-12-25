import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';

class TermsAndConditionScreen extends StatefulWidget {
  @override
  _TermsAndConditionScreenState createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  String content;
  Future getContent() async {
    var params = {"type": "APP"};
    final response =
        await ApiBase().get(context, "/mlm-service/internal/getTAndC", params, null);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        content = data["value"];
      });
      print(response.body);
    }
  }

  @override
  void initState() {
    getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: content != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      color: Color(0XFFDDF2F5),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 9.0),
                        child: Text("$content"),
                      ),
                    ),
                  ],
                ),
              )
            : content == ""
                ? Center(
                    child: Text("No Data"),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
