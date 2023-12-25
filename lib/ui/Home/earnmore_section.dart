import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/model/earn_more_model.dart';
import 'package:nexus_app/ui/EarnMore/earn_more.dart';
import 'package:nexus_app/ui/KYCDetails/kyc_details_screen.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:nexus_app/ui/Network/Lead/add_lead_screen.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import 'package:nexus_app/resources/http_requests.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:nexus_app/resources/variables.dart';

class EarnmoreSection extends StatefulWidget {
  final BranchUniversalObject buo;
  final BranchLinkProperties lp;
  const EarnmoreSection({Key key, this.buo, this.lp}) : super(key: key);

  @override
  _EarnmoreSectionState createState() =>
      _EarnmoreSectionState(buo: this.buo, lp: this.lp);
}

class _EarnmoreSectionState extends State<EarnmoreSection> {
  BranchUniversalObject buo;
  BranchLinkProperties lp;

  _EarnmoreSectionState({
    this.buo,
    this.lp,
  });

  List<EarnMore> earnMoreSecList = new List();
  reloadPage() {
    setState(() {});
  }

  Future getEarnMoreContent() async {
    final response =
        await ApiBase().get(context, "/mlm-service/getAllActivities", null, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      earnMoreSecList = earnMoreFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  void _generateDeepLink(BuildContext context) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: this.buo, linkProperties: this.lp);
    if (response.success) {
      print(response.result);
      shareReferral(response.result);
    }
  }

  Future<void> shareReferral(String result) async {
    await FlutterShare.share(
      title: 'Nexus',
      text: result,
      // 'Hey! Use my referral code ${userData.referralCode} to pre-book online on https://www.stanzaliving.com/referral/${userData.referralCode}',
      linkUrl: "www.stanzaliving.com",
      chooserTitle: 'Nexus',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Earn More",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            new InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EarnMoreScreen()));
              },
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text(
                  "See All",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
        Text(
          "Lorem ipsum dolor sit amet, consectetur",
          style: TextStyle(),
        ),
        FutureBuilder(
            future: Future.wait([getEarnMoreContent()]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.7,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        if (index < 4) {
                          return GestureDetector(
                            onTap: () {
                              if (earnMoreSecList[index].event ==
                                  "REFER_PARTNER") {
                                _generateDeepLink(context);
                              } else if (earnMoreSecList[index].event ==
                                  "KYC_COMPLETE") {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => KycDetailsScreen(
                                    reload: reloadPage,
                                  ),
                                ));
                              } else if (earnMoreSecList[index].event ==
                                  "REFER_LEAD") {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddLeadScreen()));
                              }
                            },
                            child: EarnmoreTasks(
                              title: earnMoreSecList[index].name,
                              pointsEarned: earnMoreSecList[index].points,
                            ),
                          );
                        }
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ],
    );
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
      color: Color(0XFFF6F4F5),
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
          SizedBox(
            height: 8,
          ),
          Text("$title")
        ],
      ),
    );
  }
}
