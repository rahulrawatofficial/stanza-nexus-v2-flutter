import 'package:flutter/material.dart';
import 'package:nexus_app/resources/variables.dart';

class LeaderboardSection extends StatelessWidget {
  final Function(int) navigateTab;
  const LeaderboardSection({
    Key key,
    this.navigateTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Leaderboard",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: () {
                navigateTab(3);
              },
              child: Text(
                "See All",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Text(
          "Champions of the week",
          style: TextStyle(),
        ),
        Container(
          height: 343,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Container(
                  height: 263,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0XFFEFF9F6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Win"),
                            SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/points.png",
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "1,500",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("by reaching to top 5 rank"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 48.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                LeaderboardImage(
                                  radius: 30.5,
                                  name: "Noah Hall",
                                  pointsEarned: "9,200",
                                ),
                                Positioned(
                                  top: 47,
                                  left: 41,
                                  child: Image.asset(
                                    "assets/badge3.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                LeaderboardImage(
                                  name: "Carrie Fos…",
                                  radius: 53,
                                  pointsEarned: "10,000",
                                ),
                                Positioned(
                                  top: 92,
                                  left: 41,
                                  child: Image.asset(
                                    "assets/badge1.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                LeaderboardImage(
                                  name: "Zachary K…",
                                  radius: 30.5,
                                  pointsEarned: "9,200",
                                ),
                                Positioned(
                                  top: 47,
                                  left: 41,
                                  child: Image.asset(
                                    "assets/badge2.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 233,
                left: 16,
                width: MediaQuery.of(context).size.width - 64,
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(0),
                      shadowColor: Color(0XFFDCEDC1),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.6,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your rank: 15",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "${userData.name}",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
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
                                  "1,255",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Container(
                        height: 4,
                        color: Color(0XFFDCEDC1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You are just"),
                          SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            "assets/points.png",
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "500",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("away from next rank"),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class LeaderboardImage extends StatelessWidget {
  @required
  final String name;

  @required
  final double radius;

  @required
  final String pointsEarned;
  @required
  final String badgeAsset;

  const LeaderboardImage({
    Key key,
    this.name,
    this.radius,
    this.pointsEarned,
    this.badgeAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: radius,
          // backgroundColor: Colors.greenAccent,
        ),
        SizedBox(
          height: 13,
        ),
        Container(
          width: 106,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    "$pointsEarned",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
