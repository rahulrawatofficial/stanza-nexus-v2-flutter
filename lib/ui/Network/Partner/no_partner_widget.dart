import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class NoPartnerWidget extends StatelessWidget {
  const NoPartnerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 250,
            color: Color(0XFFF6F4F5),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Image(
                      image: AssetImage(
                        "assets/onboarding/Image.png",
                      ),
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    "Bigger Network Bigger Earnings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Grow your network by referring partners and become member of the program",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  InkWell(
                    onTap: () {
                      shareReferral();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFF60C3AD),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      height: 48,
                      width: MediaQuery.of(context).size.width - 64,
                      child: Center(
                        child: Text(
                          "REFER PARTNER NOW",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
