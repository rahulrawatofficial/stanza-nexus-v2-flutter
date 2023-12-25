import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/error_alert.dart';
import 'package:nexus_app/resources/local_data.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/KYCDetails/id_details_screen.dart';
import 'package:nexus_app/ui/KYCDetails/payment_method_screen.dart';
import 'package:nexus_app/ui/KnowledgeCenter/knowledge_center_screen.dart';
import 'package:nexus_app/ui/Profile/edit_profile_screen.dart';
import 'package:nexus_app/ui/Profile/user_avatar.dart';
import 'package:nexus_app/ui/Widgets/appbar_points.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
import 'package:nexus_app/ui/onboarding/onboarding.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String versionName = "0";
  onLogout() {
    saveLogout().then((value) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Onboarding()),
        ModalRoute.withName('/')));
  }

  reloadPage() {
    setState(() {});
  }

  @override
  void initState() {
    versionCheck(context).then((value) {
      setState(() {
        versionName = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          AppbarPoints(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 47.5,
                    // ),
                    UserAvatar(
                      assetName: userData.imageUrl,
                      radius: 47.5,
                      name: userData.name,
                      enabled: true,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${userData.name}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "+91-${userData.mobileNumber}",
                          style: TextStyle(
                              // fontSize: 20,
                              // fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        userData.kycCompleted
                            ? InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Color(0XFF60C3AD),
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: Color(0XFF60C3AD),
                                    ),
                                  ),
                                  width: 100,
                                  height: 24,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 16,
                                        color: Color(0XFF60C3AD),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "KYC Verified",
                                        style: TextStyle(
                                          color: Color(0XFF60C3AD),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // onPressed: () {},
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 24,
                              ),
                      ],
                    ),
                  ],
                ),
                ProfileTile(
                  color: Color(0XFFDDF2F5),
                  title: "ID Details",
                  subTitle: "Update PAN card lower your TDS",
                  iconAsset: "assets/id.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => IdDetailsScreen(
                              reload: reloadPage,
                            )));
                  },
                ),
                ProfileTile(
                  color: Color(0XFFDDF2F5),
                  title: "Payment Method",
                  subTitle: "Update payment details",
                  iconAsset: "assets/payment_method.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentMethodScreen(
                              reload: reloadPage,
                            )));
                  },
                ),
                ProfileTile(
                  color: Color(0XFFDDF2F5),
                  title: "Personal Details",
                  subTitle: "View all your personal details",
                  iconAsset: "assets/personal_details.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfileScreen()));
                  },
                ),
                ProfileTile(
                  color: Color(0XFFDDF2F5),
                  title: "Knowledge Center",
                  subTitle: "FAQs, T&C and Contact Support",
                  iconAsset: "assets/knowledge_center.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KnowledgeCenterScreen()));
                  },
                ),
                ProfileTile(
                  color: Color(0XFFFBECDB),
                  title: "Rate Us",
                  subTitle:
                      "Take a minute to spread the word by rating us on App Store",
                  iconAsset: Platform.isIOS
                      ? "assets/rate_us.png"
                      : "assets/play_store.png",
                  onTap: () {
                    // versionCheck(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Log Out",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    ErrorAlert().showErrorDailog(context, "Logout",
                        "Are you sure you want to logout?", onLogout, true);
                  },
                ),
                Image.asset(
                  "assets/logo_profile.png",
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "v$versionName",
                  style: TextStyle(fontSize: 10, color: Color(0XFF7A7D7E)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
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
  const ProfileTile({
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
                          height: 4,
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
