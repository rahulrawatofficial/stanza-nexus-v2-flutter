import 'package:flutter/material.dart';
import 'package:nexus_app/model/redeem_tds_model.dart';
import 'package:nexus_app/ui/KYCDetails/id_details_screen.dart';

class PayoutSheet extends StatelessWidget {
  const PayoutSheet({
    Key key,
    @required this.context,
    @required this.data,
    @required this.onPress,
    @required this.panVerified,
    @required this.reloadPage,
  }) : super(key: key);

  final BuildContext context;
  final RedeemTdsModel data;
  final Function onPress;
  final bool panVerified;
  final Function reloadPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                  data.firstTdsAmount != null
                      ? Padding(
                          padding:
                              const EdgeInsets.only(top: 24.0, bottom: 24.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Color(0XFFFFEAB6)),
                            child: panVerified
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                        "Remaining TDS amount of ${data.firstTdsAmount} (against the first ${data.firstAmount} earnings) will be adjusted in your future payouts."),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Upload PAN Card and get it verified to reduce TDS deductions from 20% to 3.75%."),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        IdDetailsScreen(
                                                          reload: reloadPage,
                                                        )));
                                          },
                                          child: Text(
                                            "UPLOAD NOW",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        )
                      : Offstage(),
                  Text(
                    "TDS Breakup",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0XFF232728),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount equivalent to points",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${data.earningAmount}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  data.firstTdsAmount != null
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TDS: First ₹${data.firstAmount} (${data.firstTdsPercent})",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "-${data.firstTdsAmount}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFFF55F71),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17,
                            ),
                          ],
                        )
                      : Offstage(),
                  data.currentTdsAmount != null
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TDS: Earned Amount (${data.currentTdsPercent})",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "-${data.currentTdsAmount}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFFF55F71),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17,
                            ),
                          ],
                        )
                      : Offstage(),
                ],
              ),
            ),
            Container(
              height: 48,
              color: Color(0XFFEDFFF5),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Net Payout",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${data.netPayout}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 48),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    disabledColor: Color(0XFFA5A9A9),
                    color: Color(0XFF31C8AE),
                    child: Text(
                      "PROCEED",
                      style: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      onPress();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
