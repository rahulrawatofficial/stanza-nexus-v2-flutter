import 'package:flutter/material.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Home/share_referral.dart';
import 'package:nexus_app/ui/Network/Lead/add_lead_screen.dart';

class ReferLead extends StatelessWidget {
  const ReferLead({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Color(0XFFEDF4FF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Submit Lead Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        child: Text(
                          "We will work to convert that lead and you earn at all the 4 steps of lead journey.",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 32,
                            child: Container(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StepBox(
                                amount: "50",
                                stepNum: 1,
                                title: "Refer a Lead",
                              ),
                              StepBox(
                                amount: "200",
                                stepNum: 2,
                                title: "Lead is Qualified",
                              ),
                              StepBox(
                                amount: "500",
                                stepNum: 3,
                                title: "Lead Visits",
                              ),
                              StepBox(
                                amount: "1,500",
                                stepNum: 4,
                                title: "Lead is Booked",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    height: 122,
                    color: Color(0XFFEFF9F6),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddLeadScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Color(0XFF60C3AD),
                        ),
                      ),
                      // width: 148,
                      height: 48,
                      child: Center(
                        child: Text(
                          "REFER A LEAD NOW",
                          style: TextStyle(
                            color: Color(0XFF60C3AD),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(19.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF4E5253),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0XFFEFF9F6),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Share Referral Code With Leads",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              child: Text(
                                "Lead pre-books their stay online on www.stanzaliving.com using your referral code",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 16),
                              child: Card(
                                margin: EdgeInsets.all(0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 7.0, bottom: 7.0),
                                  child: Container(
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/points.png",
                                          height: 16,
                                          width: 16,
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          "400",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ShareReferral(
                        color: Color(0XFFFFFFFF),
                        referralCode: "${userData.referralCode}",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StepBox extends StatelessWidget {
  @required
  final int stepNum;
  @required
  final String title;
  @required
  final String amount;
  const StepBox({
    Key key,
    this.stepNum,
    this.title,
    this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Step $stepNum",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/points.png",
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    "$amount",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "$title",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
