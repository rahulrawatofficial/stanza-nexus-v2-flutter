import 'package:flutter/material.dart';
import 'package:nexus_app/model/partner_list_model.dart';
import 'package:nexus_app/model/redeem_tds_model.dart';
import 'package:nexus_app/ui/Network/Partner/partner_card.dart';
import 'package:nexus_app/ui/Network/Partner/partner_info_sheet.dart';
import 'package:nexus_app/ui/Network/Partner/search_partner_screen.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class AllPartnersList extends StatefulWidget {
  final List<PartnerListModel> data;
  const AllPartnersList({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _AllPartnersListState createState() => _AllPartnersListState();
}

class _AllPartnersListState extends State<AllPartnersList> {
  bottomSheetPartnerInfo(PartnerListModel partnerData) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            height: 700,
            decoration: BoxDecoration(
              color: Colors.white, // or some other color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
              child: PartnerInfoSheet(
                context: context,
                partnerData: partnerData,
              ),
            ),
          );
        });
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
                  "All Partners",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Tap on partner to see the earning details",
                  style: TextStyle(),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchPartnerScreen()));
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
        Column(
          children: [
            Column(
              children: List.generate(widget.data.length, (index) {
                return PartnersCard(
                  title: widget.data[index].name,
                  amount: widget.data[index].transactionPoints,
                  referrals: widget.data[index].referralCount,
                  imageUrl: widget.data[index].image,
                  onTap: () {
                    bottomSheetPartnerInfo(widget.data[index]);
                  },
                );
              }),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Color(0XFFF6F4F5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          color: Color(0XFF31C8AE),
                          child: Text(
                            "REFER PARTNER",
                            style: TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            shareReferral();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
