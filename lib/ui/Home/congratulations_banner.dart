import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CongratulationsBanner extends StatefulWidget {
  @required
  final String pointsEarned;
  final Function closeBanner;
  const CongratulationsBanner({
    Key key,
    this.pointsEarned,
    this.closeBanner,
  }) : super(key: key);

  @override
  _CongratulationsBannerState createState() => _CongratulationsBannerState();
}

class _CongratulationsBannerState extends State<CongratulationsBanner> {
  @override
  void initState() {
    Timer(Duration(seconds: 10), () {
      widget.closeBanner();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 92,
        width: 311,
        color: Color(0XFFE9FFF5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 16.0,
                  width: 16.0,
                ),
                Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.closeBanner();
                  },
                  child: SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: Image.asset("assets/close.png"),
                  ),
                )
              ],
            ),
            Text("you have won points for signup"),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset("assets/points.png"),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "${widget.pointsEarned}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
