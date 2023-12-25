import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Network/Lead/lead_methods.dart';

class LeadsCard extends StatelessWidget {
  final String name;

  final String mobile;

  final String email;

  final String status;

  final String amount;
  final Function onTap;
  const LeadsCard({
    Key key,
    @required this.amount,
    @required this.name,
    @required this.mobile,
    @required this.email,
    @required this.status,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 88,
          decoration: BoxDecoration(
              color: Color(0XFFF6F4F5), borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$name",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: statusColor(status),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
                        child: Text(
                          "${statusName(status)}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$mobile",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$email",
                      style: TextStyle(),
                    ),
                    status == "DISQUALIFIED"
                        ? Offstage()
                        : Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/points.png",
                                  height: 16,
                                  width: 16,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "$amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
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
