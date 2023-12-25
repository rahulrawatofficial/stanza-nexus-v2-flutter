import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Profile/user_avatar.dart';

class PartnersCard extends StatelessWidget {
  final String title;
  final int amount;
  final int referrals;
  final String imageUrl;
  final Function onTap;
  const PartnersCard({
    Key key,
    @required this.title,
    @required this.amount,
    @required this.referrals,
    this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
              color: Color(0XFFF6F4F5), borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        UserAvatar(
                            assetName: imageUrl,
                            radius: 20,
                            name: title,
                            enabled: true),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$title",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "$referrals Referrals",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/points.png",
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "$amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
