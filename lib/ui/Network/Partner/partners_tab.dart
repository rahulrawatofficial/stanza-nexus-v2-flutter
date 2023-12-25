import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/partner_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Partner/all_partners_list.dart';
import 'package:nexus_app/ui/Network/Partner/no_partner_widget.dart';
import 'package:nexus_app/ui/Network/network_count_box.dart';

class PartnersTab extends StatefulWidget {
  const PartnersTab({
    Key key,
  }) : super(key: key);

  @override
  _PartnersTabState createState() => _PartnersTabState();
}

class _PartnersTabState extends State<PartnersTab> {
  Future getPartnerData() async {
    var params = {
      "partnerId": "${userData.partnerId}",
      "entityType": "PARTNER"
    };
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

  Future<List<PartnerListModel>> getPartnerList() async {
    var params = {
      "partnerId": "${userData.partnerId}",
    };
    final response = await ApiBase().get(context,
        "/mlm-service/getPartnersReferredPartnerTransactionList", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<PartnerListModel> data = partnerListModelFromJson(response.body);
      return data;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: getPartnerList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (snapshot.data.length > 0)
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 24),
                    child: Column(
                      children: [
                        FutureBuilder(
                            future: getPartnerData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
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
                                          title: "Partner Earnings",
                                          amount:
                                              snapshot.data["totalEarnings"],
                                          iconAsset: "assets/points.png",
                                        ),
                                        Container(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          height: 40,
                                          width: 1,
                                        ),
                                        NetworkCount(
                                          title: "No. of Partners",
                                          amount:
                                              snapshot.data["referralCount"],
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
                                  child: Row(),
                                );
                            }),
                        SizedBox(
                          height: 24,
                        ),
                        AllPartnersList(
                          data: snapshot.data,
                        )
                      ],
                    ),
                  );
                else
                  return NoPartnerWidget();
              }
            }),
      ],
    );
  }
}
