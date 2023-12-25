import 'package:flutter/material.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Home/share_referral.dart';

class ReferPartner extends StatelessWidget {
  const ReferPartner({
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
                        "Bigger Network Bigger Earnings",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        child: Text(
                          "Multiply your earnings with each new partner you refer.",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0XFFEFF9F6),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          margin: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigNetworkStep(
                                assetName: "assets/grow_network.png",
                                title: "Grow your network",
                              ),
                              Container(
                                height: 64,
                                width: 1,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                              BigNetworkStep(
                                assetName: "assets/partner_booking.png",
                                title: "Partner get a booking",
                              ),
                              Container(
                                height: 64,
                                width: 1,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                              BigNetworkStep(
                                assetName: "assets/points.png",
                                title: "You start earning",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Container(
                            child: Text(
                              "You referred Brett as a partner and Brett refers Jane as a partner",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        BigNetworkCard(
                          title: "you get 10% of the Bretts’s earnings",
                        ),
                        BigNetworkCard(
                          title: "and 2.5% of the Jane’s earnings",
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How to Refer a Partner",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        child: Text(
                          "Share your unique code with your network and ask them to signup with your referral code",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 54),
                          child: ShareReferral(
                            color: Color(0XFFFFFFFF),
                            referralCode: "${userData.referralCode}",
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BigNetworkCard extends StatelessWidget {
  @required
  final String title;
  const BigNetworkCard({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
          child: Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/points.png",
                  height: 16,
                  width: 16,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BigNetworkStep extends StatelessWidget {
  @required
  final String title;
  @required
  final String assetName;
  const BigNetworkStep({
    Key key,
    this.title,
    this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 93,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetName,
            height: 24,
            width: 24,
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0XFF232728),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
