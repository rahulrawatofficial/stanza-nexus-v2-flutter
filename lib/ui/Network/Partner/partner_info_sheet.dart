import 'package:flutter/material.dart';
import 'package:nexus_app/model/partner_list_model.dart';
import 'package:nexus_app/model/transaction_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Partner/partner_card.dart';
import 'package:nexus_app/ui/Wallet/wallet_screen.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class PartnerInfoSheet extends StatefulWidget {
  const PartnerInfoSheet({
    Key key,
    @required this.context,
    @required this.partnerData,
  }) : super(key: key);

  final BuildContext context;
  final PartnerListModel partnerData;

  @override
  _PartnerInfoSheetState createState() => _PartnerInfoSheetState();
}

class _PartnerInfoSheetState extends State<PartnerInfoSheet> {
  bool loading = false;

  Future<List<TransactionListModel>> getTransactionList() async {
    var params = {
      "partnerId": "${userData.partnerId}",
      "entityIds": ["${widget.partnerData.id}"],
      "entityType": "PARTNER",
    };
    final response = await ApiBase().get(
        context, "/mlm-service/getPartnerTransactionsByFilters", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return transactionListModelFromJson(response.body);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  child: Image.asset(
                    "assets/close.png",
                    height: 24,
                    width: 24,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              PartnersCard(
                title: "${widget.partnerData.name}",
                amount: widget.partnerData.transactionPoints,
                referrals: widget.partnerData.referralCount,
                imageUrl: widget.partnerData.image,
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: Container(
                    color: Color(0XFFF6F4F5),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                      child: FutureBuilder(
                          future: getTransactionList(),
                          builder: (context,
                              AsyncSnapshot<List<TransactionListModel>>
                                  snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return TransactionHistoryRecord(
                                    title: snapshot.data[index].activityName,
                                    amount:
                                        "${snapshot.data[index].transactionPoint}",
                                    negative:
                                        snapshot.data[index].transactionType ==
                                                "Credit"
                                            ? false
                                            : true,
                                    time: "${dateValue(snapshot.data[index].creationDate)}",
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    )),
              ),
            ],
          ),
        ),
        loading ? Center(child: CircularProgressIndicator()) : Offstage(),
      ],
    );
  }
}
