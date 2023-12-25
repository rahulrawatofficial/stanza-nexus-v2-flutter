import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/lead_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Lead/add_lead_screen.dart';
import 'package:nexus_app/ui/Network/Lead/all_leads_list.dart';
import 'package:nexus_app/ui/Network/Lead/no_lead_widget.dart';
import 'package:nexus_app/ui/Network/network_count_box.dart';

class LeadsTab extends StatefulWidget {
  const LeadsTab({
    Key key,
  }) : super(key: key);

  @override
  _LeadsTabState createState() => _LeadsTabState();
}

class _LeadsTabState extends State<LeadsTab> {
  String leadStatus;

  Future getLeadData() async {
    var params = {"partnerId": "${userData.partnerId}", "entityType": "LEAD"};
    final response = await ApiBase().get(
        context,
        "/mlm-service/getTotalEarningsViaReferralsAndLevelOneReferralCount",
        params,
        "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future<List<LeadListModel>> getLeadList() async {
    var params = {
      "brokerMobile": "${userData.mobileNumber}",
      "searchTerm": "",
      "status": leadStatus
    };
    final response =
        await ApiBase().get(context, "/mlm-service/searchLead", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = leadListModelFromJson(response.body);
      return data;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // return NoLeadWidget();
    return FutureBuilder(
      future: getLeadList(),
      builder: (context, AsyncSnapshot<List<LeadListModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.data.length == 0 && leadStatus == null) {
            return NoLeadWidget();
          } else {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 24),
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: getLeadData(),
                          builder: (context, snapshot1) {
                            if (snapshot1.hasData)
                              return Container(
                                height: 66,
                                decoration: BoxDecoration(
                                    color: Color(0XFFDDF2F5),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16.0, top: 12.0, bottom: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      NetworkCount(
                                        title: "Lead Earnings",
                                        amount: snapshot1.data["totalEarnings"],
                                        iconAsset: "assets/points.png",
                                      ),
                                      Container(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        height: 40,
                                        width: 1,
                                      ),
                                      NetworkCount(
                                        title: "No. of Leads",
                                        amount: snapshot1.data["referralCount"],
                                        iconAsset: "assets/partner.png",
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            else
                              return Container(
                                height: 66,
                                decoration: BoxDecoration(
                                    color: Color(0XFFDDF2F5),
                                    borderRadius: BorderRadius.circular(4)),
                              );
                          }),
                      SizedBox(
                        height: 24,
                      ),
                      AllLeadsList(
                        leadList: snapshot.data,
                        leadValue: leadStatus,
                        valueChange: (change) {
                          setState(() {
                            leadStatus = change;
                          });
                          print(change);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: Color(0XFFF6F4F5),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              color: Color(0XFF31C8AE),
                              child: Text(
                                "REFER LEAD",
                                style: TextStyle(
                                  color: Color(0XFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddLeadScreen()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
