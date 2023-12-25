import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';

class TransactionTypeFilter extends StatefulWidget {
  final String currentTransactionType;
  final Function(String) transactionTypeChange;
  const TransactionTypeFilter({
    Key key,
    @required this.currentTransactionType,
    @required this.transactionTypeChange,
  }) : super(key: key);

  @override
  _TransactionTypeFilterState createState() => _TransactionTypeFilterState();
}

class _TransactionTypeFilterState extends State<TransactionTypeFilter> {
  bool earningVal = false;
  bool redeemVal = false;
  var transactionCount;

  Future getTransactionCount() async {
    var params = {"partnerId": "${userData.partnerId}"};
    final response = await ApiBase()
        .get(context, "/mlm-service/getPartnerTransactionsCount", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    getTransactionCount().then((value) {
      setState(() {
        transactionCount = value;
      });
    });
    if (widget.currentTransactionType != null) {
      if (widget.currentTransactionType == "Debit") {
        setState(() {
          redeemVal = true;
        });
      }
      if (widget.currentTransactionType == "Credit") {
        setState(() {
          earningVal = true;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (transactionCount != null) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                          "Earnings (${transactionCount["earningTransactionCount"]})"),
                      value: earningVal,
                      onChanged: (change) {
                        setState(() {
                          if (change) {
                            redeemVal = false;
                            earningVal = change;
                            widget.transactionTypeChange("Credit");
                          } else {
                            earningVal = change;
                            widget.transactionTypeChange(null);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                          "Redeemed (${transactionCount["redeemTransactionCount"]})"),
                      value: redeemVal,
                      onChanged: (change) {
                        setState(() {
                          if (change) {
                            earningVal = false;
                            redeemVal = change;
                            widget.transactionTypeChange("Debit");
                          } else {
                            redeemVal = change;

                            widget.transactionTypeChange(null);
                          }
                        });
                      },
                    ),
                  ),
                ],
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
