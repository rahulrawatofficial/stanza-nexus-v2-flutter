import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/lead_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Lead/lead_info_sheet.dart';
import 'package:nexus_app/ui/Network/Lead/lead_methods.dart';
import 'package:nexus_app/ui/Network/Lead/leader_card.dart';
import 'package:nexus_app/ui/Network/Lead/search_lead_screen.dart';
import 'package:nexus_app/ui/Network/sample_data.dart';

class AllLeadsList extends StatefulWidget {
  final List<LeadListModel> leadList;
  final Function(String) valueChange;
  final String leadValue;
  const AllLeadsList({
    Key key,
    @required this.leadList,
    this.valueChange,
    this.leadValue,
  }) : super(key: key);

  @override
  _AllLeadsListState createState() => _AllLeadsListState();
}

class _AllLeadsListState extends State<AllLeadsList> {
  Future getLeadDetails() async {
    var params = {"brokerMobile": "${userData.mobileNumber}"};
    final response =
        await ApiBase().get(context, "/mlm-service/getLeadDetails", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Leads",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Tap on lead to see the earning details",
                  style: TextStyle(),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchLeadScreen()));
              },
              child: Image.asset(
                "assets/search.png",
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        FutureBuilder(
            future: getLeadDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width - 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LeadBox(
                        amount: "${snapshot.data["inProgressLeadsCount"]}",
                        title: "In Progress",
                        color: Color(0XFFFFB701),
                        valueChange: widget.valueChange,
                        active:
                            widget.leadValue == "IN_PROGRESS" ? true : false,
                        value: "IN_PROGRESS",
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      LeadBox(
                        amount: "${snapshot.data["preBookedLeadsCount"]}",
                        title: "Pre-Booked",
                        color: Color(0XFF5FC4F5),
                        valueChange: widget.valueChange,
                        active: widget.leadValue == "PRE_BOOKED" ? true : false,
                        value: "PRE_BOOKED",
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      LeadBox(
                        amount: "${snapshot.data["bookedLeadsCount"]}",
                        title: "Booked",
                        color: Color(0XFF60C3AD),
                        valueChange: widget.valueChange,
                        active: widget.leadValue == "BOOKED" ? true : false,
                        value: "BOOKED",
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      LeadBox(
                        amount: "${snapshot.data["disquailifiedLeadsCount"]}",
                        title: "Disqualified",
                        color: Color(0XFFF55F71),
                        valueChange: widget.valueChange,
                        active:
                            widget.leadValue == "DISQUALIFIED" ? true : false,
                        value: "DISQUALIFIED",
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width - 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LeadBox(
                        amount: "",
                        title: "In Progress",
                        color: Color(0XFFFFB701),
                        active: false,
                        value: null,
                        valueChange: null,
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      LeadBox(
                        amount: "",
                        title: "Pre-Booked",
                        color: Color(0XFF5FC4F5),
                        active: false,
                        value: null,
                        valueChange: null,
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      LeadBox(
                        amount: "",
                        title: "Booked",
                        color: Color(0XFF60C3AD),
                        active: false,
                        value: null,
                        valueChange: null,
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      LeadBox(
                        amount: "",
                        title: "Disqualified",
                        color: Color(0XFFF55F71),
                        active: false,
                        value: null,
                        valueChange: null,
                      ),
                    ],
                  ),
                );
              }
            }),
        Column(
          children: List.generate(widget.leadList.length, (index) {
            return LeadsCard(
              name: widget.leadList[index].name,
              mobile: widget.leadList[index].phone,
              email: widget.leadList[index].email,
              status: widget.leadList[index].status,
              amount: "${widget.leadList[index].totalEarnings}",
              onTap: () {
                bottomSheetPartnerInfo(context, widget.leadList[index]);
              },
            );
          }),
        )
      ],
    );
  }
}

class LeadBox extends StatelessWidget {
  final String amount;
  final String title;
  final Color color;
  final Function(String) valueChange;
  final bool active;
  final String value;
  const LeadBox({
    Key key,
    this.amount,
    this.title,
    this.color,
    this.valueChange,
    this.active,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (value != null) {
            if (active) {
              valueChange(null);
            } else {
              valueChange(value);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: color,
              width: active ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "$title",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
