import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/earn_more_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/model/earn_more_model.dart';
import 'package:nexus_app/ui/EarnMore/earn_more.dart';
import 'package:nexus_app/ui/KYCDetails/kyc_details_screen.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:nexus_app/ui/Network/Lead/add_lead_screen.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/resources/http_requests.dart';

class EarnMoreScreen extends StatefulWidget {
  @override
  _EarnMoreScreenState createState() => _EarnMoreScreenState();
}

class _EarnMoreScreenState extends State<EarnMoreScreen> {
  reloadPage() {
    setState(() {});
  }

  List<EarnMore> earnMoreList;
  List<EarnMore> earnMoreSimpleList = new List();
  List<EarnMore> earnMoreGridList = new List();
  var content;
  Future getContent() async {
    await ApiBase()
        .get(context, "/mlm-service/getAllActivities", null, null)
        .then((value) {
      if (value.statusCode == 200) {
        earnMoreSimpleList.clear();
        earnMoreGridList.clear();
        var data = json.decode(value.body);
        earnMoreList = earnMoreFromJson(value.body);
        for (int i = 0; i < earnMoreList.length; i++) {
          if (i < 4) {
            earnMoreSimpleList.add(earnMoreList[i]);
          } else {
            earnMoreGridList.add(earnMoreList[i]);
          }
        }
        return data;
      } else {
        return null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Earn Points"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: FutureBuilder(
              future: Future.wait([getContent()]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: InkWell(
                              child: Card(
                                color: Color(0xFFedfff5),
                                margin: EdgeInsets.all(0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${earnMoreSimpleList[index].name}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/points.png",
                                              height: 24,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              "${earnMoreSimpleList[index].points}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (earnMoreSimpleList[index].event ==
                                    "REFER_PARTNER") {
                                  shareReferral();
                                } else if (earnMoreSimpleList[index].event ==
                                    "KYC_COMPLETE") {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => KycDetailsScreen(
                                      reload: reloadPage,
                                    ),
                                  ));
                                } else if (earnMoreSimpleList[index].event ==
                                    "REFER_LEAD") {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddLeadScreen()));
                                }
                                //_onTileClicked(earnMoreGridList[index].name,);
                              },
                            ),
                          );
                        }, childCount: earnMoreSimpleList.length)),
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.7,
                            crossAxisSpacing: 10.0,
                          ),
                          delegate: SliverChildBuilderDelegate((
                            BuildContext context,
                            int index,
                          ) {
                            return InkWell(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: EarnmoreTasks(
                                    title: earnMoreGridList[index].name,
                                    pointsEarned:
                                        earnMoreGridList[index].points,
                                  )),
                              onTap: () {
                                if (earnMoreGridList[index].event ==
                                    "REFER_PARTNER") {
                                  shareReferral();
                                } else if (earnMoreGridList[index].event ==
                                    "KYC_COMPLETE") {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => KycDetailsScreen(
                                      reload: reloadPage,
                                    ),
                                  ));
                                } else if (earnMoreGridList[index].event ==
                                    "REFER_LEAD") {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddLeadScreen()));
                                }
                                //_onTileClicked(earnMoreGridList[index].name,);
                              },
                            );
                          }, childCount: earnMoreGridList.length),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else {
                  //Show progress
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}

class EarnmoreTasks extends StatelessWidget {
  @required
  final int pointsEarned;
  @required
  final String title;
  const EarnmoreTasks({
    Key key,
    this.pointsEarned,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFFedf4ff),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/points.png",
                height: 24,
                width: 24,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "$pointsEarned",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Text("$title")
        ],
      ),
    );
  }
}
