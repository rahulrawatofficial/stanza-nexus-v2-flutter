import 'package:flutter/material.dart';
import 'package:nexus_app/model/partner_list_model.dart';
import 'package:nexus_app/model/transaction_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Lead/ToolTipLead/lead_info_step.dart';

class LeadInfoTip extends StatefulWidget {
  final String userId;
  const LeadInfoTip({
    Key key,
    @required this.userId,
  }) : super(key: key);

  @override
  _LeadInfoTipState createState() => _LeadInfoTipState();
}

class _LeadInfoTipState extends State<LeadInfoTip> {
  Future<List<TransactionListModel>> getTransactionList() async {
    var params = {
      "partnerId": "${userData.partnerId}",
      "entityIds": ["${widget.userId}"],
      "entityType": "LEAD",
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Points Breakup",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          FutureBuilder(
              future: getTransactionList(),
              builder: (context,
                  AsyncSnapshot<List<TransactionListModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: List.generate(snapshot.data.length, (index) {
                      return LeadInfoStep(
                        title: snapshot.data[index].activityName,
                        stepNum: "${index + 1}",
                        amount: "${snapshot.data[index].transactionPoint}",
                        lastStep:
                            index + 1 == snapshot.data.length ? true : false,
                      );
                    }),
                  );
                }
              })
        ],
      ),
    );
  }
}
