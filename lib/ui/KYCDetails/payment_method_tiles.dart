import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';

class PaymentMethodTile extends StatelessWidget {
  @required
  final Color color;
  @required
  final String iconAsset;
  @required
  final String title;
  @required
  final String subTitle;
  @required
  final Function onTap;
  const PaymentMethodTile({
    Key key,
    this.color,
    this.iconAsset,
    this.title,
    this.subTitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), color: color),
          // color: color,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0XFFFFFFFF),
                      // backgroundImage: AssetImage(iconAsset),
                      child: Image.asset(
                        iconAsset,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 231,
                          child: Text(
                            subTitle,
                            style: TextStyle(
                                // fontSize: 20,
                                // fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.navigate_next)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodTileFilled extends StatefulWidget {
  @required
  final Color color;
  @required
  final String iconAsset;
  @required
  final String title;
  @required
  final String subTitle;
  @required
  final Function onTap;
  @required
  final String modeId;
  @required
  final bool preferred;
  @required
  final Function refresh;
  const PaymentMethodTileFilled({
    Key key,
    this.color,
    this.iconAsset,
    this.title,
    this.subTitle,
    this.onTap,
    this.preferred,
    this.modeId,
    this.refresh,
  }) : super(key: key);

  @override
  _PaymentMethodTileFilledState createState() =>
      _PaymentMethodTileFilledState();
}

class _PaymentMethodTileFilledState extends State<PaymentMethodTileFilled> {
  Future paymentModeChange(String modeId) async {
    var params = {
      "brokerMobile": "${userData.mobileNumber}",
      "paymentModeId": modeId
    };
    final response = await ApiBase()
        .put(context, "/mlm-service/changeBrokerPaymentMode", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {});
      return data;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), color: widget.color),
          // color: color,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0XFFFFFFFF),
                      // backgroundImage: AssetImage(iconAsset),
                      child: Image.asset(
                        widget.iconAsset,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 112,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              widget.preferred
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Color(0XFFFAB432),
                                          borderRadius:
                                              BorderRadius.circular(4.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            13, 3, 13, 3),
                                        child: Text(
                                          "PREFERRED",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Offstage(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 112,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "${widget.subTitle}",
                                  style: TextStyle(
                                      // fontSize: 20,
                                      // fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Icon(
                                Icons.check_circle_outline,
                                size: 16,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 112,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  "EDIT",
                                  style: TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              !widget.preferred
                                  ? SizedBox(
                                      width: 24,
                                    )
                                  : Offstage(),
                              !widget.preferred
                                  ? InkWell(
                                      onTap: () {
                                        paymentModeChange(widget.modeId)
                                            .then((value) {
                                          widget.refresh();
                                        });
                                      },
                                      child: Text(
                                        "MARK AS PREFERRED",
                                        style: TextStyle(
                                          // fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  : Offstage(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
