import 'package:flutter/material.dart';
import 'package:nexus_app/model/lead_list_model.dart';
import 'package:nexus_app/ui/Network/Lead/lead_methods.dart';
import 'package:nexus_app/ui/Network/Lead/ToolTipLead/target_widget.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:super_tooltip/super_tooltip.dart';

class LeadInfoSheet extends StatefulWidget {
  const LeadInfoSheet({
    Key key,
    @required this.context,
    @required this.leadData,
  }) : super(key: key);

  final BuildContext context;
  final LeadListModel leadData;

  @override
  _LeadInfoSheetState createState() => _LeadInfoSheetState();
}

class _LeadInfoSheetState extends State<LeadInfoSheet> {
  bool loading = false;

  // Future<List<TransactionListModel>> getTransactionList() async {
  //   var params = {
  //     "partnerId": "${userData.partnerId}",
  //     "entityIds": ["${widget.partnerData.id}"],
  //     "entityType": "PARTNER",
  //   };
  //   final response = await ApiBase().get(
  //       context, "/mlm-service/getPartnerTransactionsByFilters", params, "");
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     return transactionListModelFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.leadData.name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: statusColor(widget.leadData.status),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
                      child: Text(
                        "${statusName(widget.leadData.status)}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Visibility(
                visible: (widget.leadData.email == null || widget.leadData.email=="") ? false : true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${widget.leadData.email}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  LeadSheetContentRow(
                    title: "Contact Number",
                    subTitle: widget.leadData.phone,
                  ),
                  SizedBox(
                    width: 27,
                  ),
                  LeadSheetContentRow(
                    title: "Locality/ City",
                    subTitle:
                        "${widget.leadData.microMarket}, ${widget.leadData.city}",
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  LeadSheetContentRow(
                    title: "Submitted On",
                    subTitle: "${dateValue(widget.leadData.submittedOn)}",
                  ),
                  SizedBox(
                    width: 27,
                  ),
                  widget.leadData.preBookedOn != null
                      ? LeadSheetContentRow(
                          title: "Pre-Booked On",
                          subTitle: "${widget.leadData.preBookedOn}",
                        )
                      : Offstage(),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Points Earned",
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/points.png",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${widget.leadData.totalEarnings}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      TargetWidget(
                        userId: widget.leadData.phone,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        loading ? Center(child: CircularProgressIndicator()) : Offstage(),
      ],
    );
  }
}

class LeadSheetContentRow extends StatelessWidget {
  final String title;
  final String subTitle;
  const LeadSheetContentRow({
    Key key,
    @required this.title,
    @required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 59) / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "$subTitle",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
