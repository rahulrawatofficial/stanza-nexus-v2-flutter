import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/model/partner_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_screen_methods.dart';

class FilterByPartner extends StatefulWidget {
  final List<String> currentIdList;
  final Function(List<String>) idListChange;
  const FilterByPartner({
    Key key,
    @required this.currentIdList,
    @required this.idListChange,
  }) : super(key: key);

  @override
  _FilterByPartnerState createState() => _FilterByPartnerState();
}

class _FilterByPartnerState extends State<FilterByPartner> {
  List<PartnerListModel> partnerList;
  List<String> partnerNameList = [];
  List<String> partnerIdList = [];
  List<bool> pListBool = [];
  bool selectAll = false;
  List<String> partnerFilterList = [];

  Future<List<PartnerListModel>> getPartnerList() async {
    var params = {
      "partnerId": "${userData.partnerId}",
    };
    final response = await ApiBase().get(context,
        "/mlm-service/getPartnersReferredPartnerTransactionList", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<PartnerListModel> data = partnerListModelFromJson(response.body);
      setState(() {
        partnerList = data;
        print(partnerList.length);
        for (int i = 0; i < partnerList.length; i++) {
          partnerNameList.add(partnerList[i].name);
          partnerIdList.add(partnerList[i].id);
          pListBool.add(false);
        }
      });
      return data;
    } else {
      return null;
    }
  }

  alreadyAddedFilters() {
    partnerFilterList = widget.currentIdList;
    for (int i = 0; i < partnerFilterList.length; i++) {
      if (partnerIdList.contains(partnerFilterList[i])) {
        setState(() {
          pListBool[partnerIdList.indexOf(partnerFilterList[i].toString())] =
              true;
        });
      }
    }
  }

  @override
  void initState() {
    getPartnerList().then((value) {
      alreadyAddedFilters();
      if (allTrue(pListBool)) {
        setState(() {
          selectAll = true;
        });
      }
    });
    super.initState();
  }

  changeAll(bool status) {
    setState(() {
      for (int i = 0; i < pListBool.length; i++) {
        pListBool[i] = status;
      }
    });
  }

  createPartnerFilterList() {
    partnerFilterList.clear();
    for (int i = 0; i < pListBool.length; i++) {
      if (pListBool[i] == true) {
        partnerFilterList.add(partnerList[i].id);
      }
    }
    print(partnerFilterList);
    widget.idListChange(partnerFilterList);
  }

  @override
  Widget build(BuildContext context) {
    if (partnerList != null) {
      return Container(
        // color: Colors.green,
        // width: 135,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            partnerList.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            dense: true,
                            contentPadding: EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('All'),
                            value: selectAll,
                            onChanged: (change) {
                              setState(() {
                                selectAll = change;
                              });
                              changeAll(change);
                              createPartnerFilterList();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Offstage(),
            Expanded(
              child: ListView.builder(
                itemCount: partnerNameList.length,
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
                                "${partnerNameList[index]} (${partnerList[index].transactionCount})"),
                            value: pListBool[index],
                            onChanged: (change) {
                              setState(() {
                                pListBool[index] = change;
                                if (change && allTrue(pListBool)) {
                                  selectAll = true;
                                } else {
                                  selectAll = false;
                                }
                              });
                              createPartnerFilterList();
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
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
