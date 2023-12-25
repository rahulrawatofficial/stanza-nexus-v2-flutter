import 'package:flutter/material.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Profile/user_avatar.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                // CircleAvatar(
                //   radius: 24.0,
                //   backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                //   // radius: 20.15,
                // ),
                UserAvatar(
                  assetName: userData.imageUrl,
                  radius: 24.0,
                  name: userData.name,
                  enabled: true,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome"),
                    Text(
                      "${userData.name}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  "assets/notification_icon.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
