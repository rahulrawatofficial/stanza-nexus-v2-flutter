import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/activity_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_screen_methods.dart';

class ActivityTypeFilter extends StatefulWidget {
  final List<String> currentIdList;
  final Function(List<String>) idListChange;
  const ActivityTypeFilter({
    Key key,
    @required this.currentIdList,
    @required this.idListChange,
  }) : super(key: key);

  @override
  _ActivityTypeFilterState createState() => _ActivityTypeFilterState();
}

class _ActivityTypeFilterState extends State<ActivityTypeFilter> {
  List<ActivityModel> activityList = [];
  List<String> activityNameList = [];
  List<String> activityIdList = [];
  List<bool> aListBool = [];
  bool selectAll = false;
  List<String> activityFilterList = [];

  Future<List<ActivityModel>> getActivityList() async {
    var params = {"partnerId": "${userData.partnerId}"};
    final response = await ApiBase()
        .get(context, "/mlm-service/searchActivitiesByPartnerId", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<ActivityModel> data = activityModelFromJson(response.body);
      setState(() {
        activityList = data;
        print(activityList.length);
        for (int i = 0; i < activityList.length; i++) {
          activityNameList.add(activityList[i].activityName);
          activityIdList.add(activityList[i].activityId.toString());
          aListBool.add(false);
        }
      });
      return data;
    } else {
      return null;
    }
  }

  alreadyAddedFilters() {
    activityFilterList = widget.currentIdList;
    for (int i = 0; i < activityFilterList.length; i++) {
      if (activityIdList.contains(activityFilterList[i])) {
        setState(() {
          aListBool[activityIdList.indexOf(activityFilterList[i].toString())] =
              true;
        });
      }
    }
  }

  @override
  void initState() {
    getActivityList().then((value) {
      alreadyAddedFilters();
      if (allTrue(aListBool)) {
        setState(() {
          selectAll = true;
        });
      }
    });
    super.initState();
  }

  changeAll(bool status) {
    setState(() {
      for (int i = 0; i < aListBool.length; i++) {
        aListBool[i] = status;
      }
    });
  }

  createActivityFilterList() {
    activityFilterList.clear();
    for (int i = 0; i < aListBool.length; i++) {
      if (aListBool[i] == true) {
        activityFilterList.add(activityList[i].activityId.toString());
      }
    }

    widget.idListChange(activityFilterList);
    // print(activityFilterList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          activityList.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(0),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("All"),
                          value: selectAll,
                          onChanged: (change) {
                            setState(() {
                              selectAll = change;
                            });
                            changeAll(change);
                            createActivityFilterList();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Offstage(),
          Expanded(
            child: ListView.builder(
              itemCount: activityList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(0),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                              "${activityList[index].activityName} (${activityList[index].transactionCount})"),
                          value: aListBool[index],
                          onChanged: (change) {
                            setState(() {
                              aListBool[index] = change;
                              if (change && allTrue(aListBool)) {
                                selectAll = true;
                              } else {
                                selectAll = false;
                              }
                            });
                            createActivityFilterList();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 72,
          ),
        ],
      ),
    );
  }
}
