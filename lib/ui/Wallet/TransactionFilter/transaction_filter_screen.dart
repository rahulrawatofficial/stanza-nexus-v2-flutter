import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/activity_type_filter.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/date_range_filter.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_by_lead.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_by_partner.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_screen_methods.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_tab.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/transaction_type_filter.dart';

class TransactionFilterScreen extends StatefulWidget {
  @override
  _TransactionFilterScreenState createState() =>
      _TransactionFilterScreenState();
}

class _TransactionFilterScreenState extends State<TransactionFilterScreen> {
  List<String> activityIdList = [];
  List<String> partnerIdList = [];
  List<String> leadIdList = [];
  String transactionType;

  DateTime fromDate;
  DateTime toDate;

  List filterTypes = [
    "Transaction Type",
    "Filter By Partner",
    "Filter By Lead",
    "Activity Type",
    "Date Range"
  ];

  String currentFilter = "Transaction Type";
  int widgetIndex = 0;

  @override
  void initState() {
    activityIdList = finalActivityIdList;
    partnerIdList = finalPartnerIdList;
    leadIdList = finalLeadIdList;
    transactionType = finalTransactionType;

    fromDate = finalFromDate;
    toDate = finalToDate;
    super.initState();
  }

  setFinalFilters() {
    finalActivityIdList = activityIdList;
    finalPartnerIdList = partnerIdList;
    finalLeadIdList = leadIdList;
    finalTransactionType = transactionType;

    finalFromDate = fromDate;
    finalToDate = toDate;
  }

  clearAllFilters() {
    setState(() {
      activityIdList = [];
      partnerIdList = [];
      leadIdList = [];
      transactionType = null;

      fromDate = null;
      toDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(activityIdList);
    List<Widget> filterWidget = [
      TransactionTypeFilter(
        currentTransactionType: transactionType,
        transactionTypeChange: (change) {
          setState(() {
            transactionType = change;
          });
        },
      ),
      FilterByPartner(
        currentIdList: partnerIdList,
        idListChange: (change) {
          setState(() {
            partnerIdList = change;
          });
        },
      ),
      FilterByLead(
        currentIdList: leadIdList,
        idListChange: (change) {
          setState(() {
            leadIdList = change;
          });
        },
      ),
      ActivityTypeFilter(
        currentIdList: activityIdList,
        idListChange: (change) {
          setState(() {
            activityIdList = change;
          });
        },
      ),
      DateRangeFilter(
        currentFromDate: fromDate,
        fromDateChange: (val) {
          setState(() {
            fromDate = val;
          });
        },
        currentToDate: toDate,
        toDateChange: (val) {
          setState(() {
            toDate = val;
          });
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: Stack(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height - 72,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  width: 135,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(filterTypes.length, (index) {
                            return FilterTab(
                              title: filterTypes[index],
                              currentTab: filterTypes[index] == currentFilter
                                  ? true
                                  : false,
                              changeTab: (change) {
                                setState(() {
                                  currentFilter = change;
                                  print(change);
                                  widgetIndex = index;
                                });
                              },
                            );
                          })),
                    ],
                  ),
                ),
                Expanded(
                  child: filterWidget[widgetIndex],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ]),
              height: 72,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        clearAllFinalFilters();
                        clearAllFilters();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Color(0XFF60C3AD),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Color(0XFF60C3AD),
                          ),
                        ),
                        width: 163,
                        height: 48,
                        child: Center(
                          child: Text(
                            "CLEAR ALL",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF60C3AD),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // onPressed: () {},
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setFinalFilters();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0XFF60C3AD),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        width: 163,
                        height: 48,
                        child: Center(
                          child: Text(
                            "APPLY",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
