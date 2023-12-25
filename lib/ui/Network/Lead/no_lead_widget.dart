import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Network/Lead/add_lead_screen.dart';

class NoLeadWidget extends StatelessWidget {
  const NoLeadWidget({
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
                        "assets/no_lead.png",
                      ),
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    "Refer a Lead and Earn",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Start referring leads here by providing their basic details",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddLeadScreen()));
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
                          "REFER LEAD NOW",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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
