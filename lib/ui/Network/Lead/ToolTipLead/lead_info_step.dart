import 'package:flutter/material.dart';

class LeadInfoStep extends StatelessWidget {
  final String title;
  final String stepNum;
  final String amount;
  final bool lastStep;
  const LeadInfoStep({
    Key key,
    @required this.title,
    @required this.stepNum,
    @required this.amount,
    @required this.lastStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step $stepNum",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                    child: Container(
                      width: 65,
                      height: 25,
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
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                !lastStep
                    ? Container(
                        width: 1,
                        height: 24,
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                      )
                    : Offstage(),
              ],
            )
          ],
        )
      ],
    );
  }
}
