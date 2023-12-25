import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/lead_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Lead/lead_methods.dart';
import 'package:nexus_app/ui/Network/Lead/leader_card.dart';
import 'package:nexus_app/ui/Network/no_user_found_widget.dart';

class SearchLeadScreen extends StatefulWidget {
  @override
  _SearchLeadScreenState createState() => _SearchLeadScreenState();
}

class _SearchLeadScreenState extends State<SearchLeadScreen> {
  String searchText = "";
  var _controller = TextEditingController();

  Future<List<LeadListModel>> getLeadList() async {
    var params = {
      "brokerMobile": "${userData.mobileNumber}",
      "searchTerm": searchText,
      "status": ""
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
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 36,
          // width: 411,
          color: Color(0XFFFAFBFB),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(16, 2, 16, 6),
              suffixIcon: _controller.text.toString() == ""
                  ? Icon(Icons.search, color: Color(0XFF4E5253))
                  : IconButton(
                      onPressed: () => {
                        setState(
                          () {
                            searchText = "";
                            _controller.clear();
                          },
                        ),
                      },
                      icon: Icon(Icons.clear, color: Color(0XFF4E5253)),
                    ),
              hintText: "Search Lead",
              hintStyle: TextStyle(fontSize: 16, color: Color(0XFF7A7D7E)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                searchText = text;
              });
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: getLeadList(),
        builder: (context, AsyncSnapshot<List<LeadListModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.length > 0) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return LeadsCard(
                      name: snapshot.data[index].name,
                      mobile: snapshot.data[index].phone,
                      email: snapshot.data[index].email,
                      status: snapshot.data[index].status,
                      amount: "${snapshot.data[index].totalEarnings}",
                      onTap: () {
                        bottomSheetPartnerInfo(context, snapshot.data[index]);
                      },
                    );
                  },
                ),
              );
            } else {
              
              return NoUserFoundWidget(
                searchText: searchText,
              );
            }
          }
        },
      ),
    );
  }
}
