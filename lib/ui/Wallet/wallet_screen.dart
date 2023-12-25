import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/model/transaction_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Home/virtual_creditcard.dart';
import 'package:nexus_app/ui/Home/wallet_apis.dart';
import 'package:nexus_app/ui/Wallet/RedeemPoints/redeem_points_screen.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_screen_methods.dart';
import 'package:nexus_app/ui/Wallet/TransactionFilter/transaction_filter_screen.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // ScrollController _scrollController = ScrollController();
  // List<TransactionListModel> data = [];
  // int pageNum = 0;
  // bool addList = true;
  // bool datafull = false;

  Future<List<TransactionListModel>> getTransactionList() async {
    entityIdsList.clear();
    for (int i = 0; i < finalPartnerIdList.length; i++) {
      entityIdsList.add(finalPartnerIdList[i]);
    }
    for (int i = 0; i < finalLeadIdList.length; i++) {
      entityIdsList.add(finalLeadIdList[i]);
    }
    print(finalLeadIdList);
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    var params = {
      "partnerId": "${userData.partnerId}",
      "start": "0",
      // "start": "$pageNum",
      "size": "10",
      "activityIds": finalActivityIdList,
      "transactionType": finalTransactionType,
      "entityIds": entityIdsList,
      "fromDate":
          finalFromDate != null ? formatter.format(finalFromDate) : null,
      "toDate": finalToDate != null
          ? formatter.format(finalToDate.add(Duration(days: 1)))
          : null
    };
    final response = await ApiBase().get(
        context, "/mlm-service/getPartnerTransactionsByFilters", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // List<TransactionListModel> d =
      //     transactionListModelFromJson(response.body);
      // if (addList) {
      //   for (int i = 0; i < d.length; i++) {
      //     data.add(d[i]);
      //   }
      //   if (d.length == 0) {
      //     datafull = true;
      //   }
      // }
      // addList = false;
      // print("**${data.length}");
      // return data;
      return transactionListModelFromJson(response.body);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     setState(() {
    //       pageNum++;
    //       addList = true;
    //     });
    //     print(pageNum);
    //   }
    // });
    clearAllFinalFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Offstage(),
        title: Text("Wallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          // controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Card(
                margin: EdgeInsets.all(0),
                child: Column(
                  children: [
                    VCreditCard(),
                    FutureBuilder(
                        future: getWalletDetails(context),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 16.0, top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PointsCount(
                                    title: "Total Earnings",
                                    amount:
                                        "${snapshot.data["totalEarnings"].toInt()}",
                                    negative: false,
                                  ),
                                  Container(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    height: 40,
                                    width: 1,
                                  ),
                                  PointsCount(
                                    title: "Redeemed",
                                    amount:
                                        "${snapshot.data["totalRedeemedPoints"].toInt()}",
                                    negative: true,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 16.0, top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PointsCount(
                                    title: "Total Earnings",
                                    amount: "",
                                    negative: false,
                                  ),
                                  Container(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    height: 40,
                                    width: 1,
                                  ),
                                  PointsCount(
                                    title: "Redeemed",
                                    amount: "",
                                    negative: true,
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RedeemPointsScreen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0XFF60C3AD),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              width: MediaQuery.of(context).size.width - 64,
                              height: 36,
                              child: Center(
                                child: Text(
                                  "REDEEM VIA CASH",
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transaction History",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Your recent transactions",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TransactionFilterScreen()));
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/filter.png",
                          height: 24,
                          width: 24,
                        ),
                        filterAddedStatus()
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Color(0XFFF55F71),
                                ),
                              )
                            : Offstage(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Color(0XFFF6F4F5),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 12, 16),
                  child: FutureBuilder(
                      future: getTransactionList(),
                      builder: (context,
                          AsyncSnapshot<List<TransactionListModel>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                              color: Color(0XFFF6F4F5),
                              height: 386,
                              width: MediaQuery.of(context).size.width - 32,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else {
                          if (snapshot.data.length > 0) {
                            return Column(
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                String title = snapshot
                                            .data[index].commissionType ==
                                        "Commission_Level_One"
                                    ? "${snapshot.data[index].activityName}: By ${snapshot.data[index].name}"
                                    : snapshot.data[index].commissionType ==
                                            "Commission_Level_Two"
                                        ? "${snapshot.data[index].activityName}: By ${snapshot.data[index].name}'s partner"
                                        : snapshot.data[index].activityName;
                                return TransactionHistoryRecord(
                                  title: title,
                                  amount:
                                      "${snapshot.data[index].transactionPoint}",
                                  negative:
                                      snapshot.data[index].transactionType ==
                                              "Credit"
                                          ? false
                                          : true,
                                  time:
                                      "${dateValue(snapshot.data[index].creationDate)} ${timeValue(snapshot.data[index].creationDate)}",
                                );
                              }),
                            );
                          } else {
                            return Container(
                              color: Color(0XFFF6F4F5),
                              height: 386,
                              width: MediaQuery.of(context).size.width - 32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24.0, bottom: 24.0),
                                    child: CircleAvatar(
                                      radius: 100,
                                      backgroundColor: Color(0XFFE5DBD9),
                                      child: Image.asset(
                                        "assets/empty_trans.png",
                                        height: 200,
                                        width: 200,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Refer a Lead and Earn",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "It seems you have not transacted recently. Your transactions after ${dateValue(userData.createdAt)} will be shown here.",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionHistoryRecord extends StatelessWidget {
  @required
  final String title;
  @required
  final String amount;
  @required
  final bool negative;
  @required
  final String time;
  const TransactionHistoryRecord({
    Key key,
    this.title,
    this.amount,
    this.negative,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
          child: Container(
            // height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "$title",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          // fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "$time",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    negative
                        ? Text(
                            "-",
                            style: TextStyle(
                              color: Color(0XFFF55F71),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            "+",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    SizedBox(
                      width: 4,
                    ),
                    negative
                        ? Image.asset(
                            "assets/redeem_points.png",
                            height: 16,
                            width: 16,
                          )
                        : Image.asset(
                            "assets/points.png",
                            height: 16,
                            width: 16,
                          ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$amount",
                      style: TextStyle(
                        // fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 1,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        )
      ],
    );
  }
}

class PointsCount extends StatelessWidget {
  @required
  final String title;
  @required
  final String amount;
  @required
  final bool negative;
  const PointsCount({
    Key key,
    this.title,
    this.amount,
    this.negative,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 65) / 2,
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0XFFEDFFF5),
            child: negative
                ? Image.asset(
                    "assets/redeem_points.png",
                    height: 24,
                    width: 24,
                  )
                : Image.asset(
                    "assets/points.png",
                    height: 24,
                    width: 24,
                  ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              amount == "0"
                  ? Text(
                      "$amount",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFFF55F71)),
                    )
                  : negative
                      ? Text(
                          "-$amount",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFFF55F71)),
                        )
                      : Text(
                          "$amount",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            ],
          ),
        ],
      ),
    );
  }
}
