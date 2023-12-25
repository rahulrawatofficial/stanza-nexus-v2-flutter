import 'package:flutter/material.dart';

class PanContent extends StatelessWidget {
  final String panName;
  final String panNumber;
  const PanContent({
    Key key,
    this.panName,
    this.panNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 112,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "$panName",
                  style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      // fontSize: 10,
                      ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "PAN Number",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "$panNumber",
                  style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      // fontSize: 10,
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class PaymentContent extends StatelessWidget {
  final String paytmNumber;
  final String bankAccount;
  final String vpa;
  const PaymentContent({
    Key key,
    this.paytmNumber,
    this.bankAccount,
    this.vpa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paytmNumber != null
            ? Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width - 112,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
              )
            : Offstage(),
        paytmNumber != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Paytm",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "$paytmNumber",
                    style: TextStyle(),
                  ),
                ],
              )
            : Offstage(),
        bankAccount != null
            ? Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width - 112,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
              )
            : Offstage(),
        bankAccount != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BANK ACCOUNT",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "$bankAccount",
                    style: TextStyle(),
                  ),
                ],
              )
            : Offstage(),
        vpa != null
            ? Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width - 112,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
              )
            : Offstage(),
        vpa != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "UPI",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "$vpa",
                    style: TextStyle(),
                  ),
                ],
              )
            : Offstage(),
      ],
    );
  }
}

class KYCTile extends StatelessWidget {
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
  final Widget extraData;
  const KYCTile({
    Key key,
    this.color,
    this.iconAsset,
    this.title,
    this.subTitle,
    this.onTap,
    this.extraData,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
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
                extraData != null
                    ? Container(
                        width: MediaQuery.of(context).size.width - 112,
                        child: extraData,
                      )
                    : Offstage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
