import 'package:flutter/material.dart';
import 'package:nexus_app/ui/bottom_navigation.dart';

class CongratulationsScreen extends StatefulWidget {
  final int points;
  final int amount;

  const CongratulationsScreen(
      {Key key, @required this.points, @required this.amount})
      : super(key: key);
  @override
  _CongratulationsScreenState createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/congratulation_map.png",
                height: 292,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
          Positioned(
            top: 55,
            child: Image.asset(
              "assets/congratulation_person.png",
              height: 511,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white, // or some other color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              height: 348,
              child: Column(
                children: [
                  SizedBox(
                    height: 48,
                  ),
                  Text(
                    "Congratulations!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "You have successfully redeemed ${widget.points}\npoints worth ₹${widget.amount} via Cash to your\nregistered Paytm account",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
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
                                "BACK TO HOME",
                                style: TextStyle(
                                  color: Color(0XFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeNavigationBar()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
