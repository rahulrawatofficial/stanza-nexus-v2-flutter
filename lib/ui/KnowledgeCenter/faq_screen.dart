import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List titleList = [
    "Tell me something about Stanza Living?",
    "Which cities does Stanza Living operate in?",
    "Tell me something about Stanza Living?",
    "How much rent will I have to pay? And is it the same for all residences?",
    "Say I’ve paid for my room. What all do I get with it?",
    "And how many people will I share the entire residence with?",
    "What are the steps taken to ensure security in the residences?",
    "Who will keep my room and the common areas clean?",
    "How many people will I have to share my room with?",
    "Are Stanza residences unisex?",
  ];

  var content;
  Future getContent() async {
    var params = {"type": "APP"};
    final response =
        await ApiBase().get(context, "/mlm-service/internal/getFAQs", params, null);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        content = data;
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
        title: Text("FAQ"),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(content.length, (index) {
                          return FaqTile(
                            title: "${content[index]["question"]}",
                            description: "${content[index]["answer"]}",
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class FaqTile extends StatelessWidget {
  final String title;
  final String description;
  const FaqTile({
    Key key,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          tilePadding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          childrenPadding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 16.0, top: 0),
          title: Text(
            "$title",
            style: TextStyle(color: Color(0XFF232728)),
          ),
          children: [
            Text("$description",
                style: TextStyle(color: Color(0XFF232728), fontSize: 12)),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width - 64,
          color: Color.fromRGBO(0, 0, 0, 0.1),
          height: 1,
        )
      ],
    );
  }
}
