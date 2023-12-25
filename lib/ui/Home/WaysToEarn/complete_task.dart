import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nexus_app/ui/EarnMore/earn_more.dart';
import 'package:nexus_app/model/earn_more_model.dart';
import 'package:nexus_app/ui/EarnMore/earn_more.dart';
import 'package:nexus_app/ui/Home/WaysToEarn/ExploreAllTasks/explore_all_tasks.dart';
import 'package:nexus_app/ui/KYCDetails/kyc_details_screen.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:nexus_app/ui/Network/Lead/add_lead_screen.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/resources/http_requests.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({
    Key key,
  }) : super(key: key);
  @override
  _CompleteTaskState createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  reloadPage() {
    setState(() {});
  }

  List<EarnMore> completeTaskList = new List();

  Future getCompleteTaskContent() async {
    var params = {"partnerId": "${userData.partnerId}"};
    final response = await ApiBase()
        .get(context, "/mlm-service/getActivitiesByPartnerId", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      completeTaskList = earnMoreFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Color(0XFFEDF4FF),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Complete Tasks and Challenges",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: Text(
                      "Increase your earnings and remain on top of the game",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: Future.wait([getCompleteTaskContent()]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  if (index < 5) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (completeTaskList[index].event ==
                                            "REFER_PARTNER") {
                                          shareReferral();
                                        } else if (completeTaskList[index]
                                                .event ==
                                            "KYC_COMPLETE") {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                KycDetailsScreen(
                                              reload: reloadPage,
                                            ),
                                          ));
                                        } else if (completeTaskList[index]
                                                .event ==
                                            "REFER_LEAD") {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddLeadScreen()));
                                        }
                                      },
                                      child: CompleteTaskCard(
                                        title: completeTaskList[index].name,
                                        amount: completeTaskList[index].points,
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
                      }),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "*Tasks are added on a regular basis, don’t miss a chance to win daily and be on top of the Leaderboard.",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7A7D7E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0XFFFFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Color(0XFF60C3AD),
                          ),
                        ),
                        // width: 148,
                        height: 48,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "EXPLORE ALL TASKS",
                              style: TextStyle(
                                color: Color(0XFF60C3AD),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ExploreAllTasksScreen()));
                          },
                        ),
                        // onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<EarnMore>('earnMoreSecList', completeTaskList));
  }
}

class CompleteTaskCard extends StatelessWidget {
  @required
  final String title;
  @required
  final int amount;
  const CompleteTaskCard({
    Key key,
    this.title,
    this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$title",
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
                      "$amount",
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
    );
  }
}
