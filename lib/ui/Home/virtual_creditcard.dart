import 'package:flutter/material.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class VCreditCard extends StatefulWidget {
  final Function(int) currentPoints;
  const VCreditCard({
    Key key,
    this.currentPoints,
  }) : super(key: key);

  @override
  _VCreditCardState createState() => _VCreditCardState();
}

class _VCreditCardState extends State<VCreditCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(29, 32, 43, 0.9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: MediaQuery.of(context).size.width - 32,
          height: 187,
          child: Image.asset(
            "assets/texture.png",
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 32,
          height: 187,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fill,
                      width: 47,
                      height: 24,
                    ),
                    Container(
                      width: 58,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0XFF283042),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "BLACK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/points.png",
                            fit: BoxFit.fill,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${currentBalance.toInt()}",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/chip.png",
                      fit: BoxFit.fill,
                      width: 42,
                      height: 37,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userData.name.toString().toUpperCase()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Member Since ${dateValueMonth(userData.createdAt)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/points.png",
                                  fit: BoxFit.fill,
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "1",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 10,
                            ),
                            child: Text("=",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                )),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/points.png",
                                  fit: BoxFit.fill,
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "1",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

