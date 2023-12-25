import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Home/congratulations_banner.dart';
import 'package:nexus_app/ui/Home/WaysToEarn/refer_ways.dart';
import 'package:nexus_app/ui/Home/earnmore_section.dart';
import 'package:nexus_app/Constants/app_constant.dart';
import 'package:nexus_app/ui/Home/leaderboard_section.dart';
import 'package:nexus_app/ui/Home/share_referral.dart';
import 'package:nexus_app/ui/Home/top_banner.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:nexus_app/ui/Home/video_player_section.dart';
import 'package:nexus_app/ui/Home/virtual_creditcard.dart';
import 'package:nexus_app/ui/Home/wallet_apis.dart';
import 'package:nexus_app/ui/Wallet/RedeemPoints/redeem_points_screen.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/ui/EarnMore/earn_more.dart';

class HomeScreen extends StatefulWidget {
  final String g;
  final Function(int) navigateTab;

  const HomeScreen({Key key, this.g, this.navigateTab}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

StreamSubscription<Map> streamSubscriptionDeepLink;

class _HomeScreenState extends State<HomeScreen> {
  BranchUniversalObject buo;
  BranchLinkProperties lp;
  BranchResponse response;

  ConfettiController _controllerCenter;
  //Close Congratulations Banner
  closeBanner() {
    setState(() {
      cBanner = false;
    });
  }

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    getWalletDetails(context).then((value) {
      getConversionRate(context).then((value) {
        setState(() {});
      });
    });
    if (cBanner) {
      _controllerCenter.play();
    }
    super.initState();
    Future.delayed(Duration.zero, () {
      listenDeepLinkData(context);
    });
    initializeDeepLinkData();
  }

  //To Listen Generated Branch IO Link And Get Data From It
  void listenDeepLinkData(BuildContext context) async {
    streamSubscriptionDeepLink = FlutterBranchSdk.initSession().listen((data) {
      if (data.containsKey(AppConstants.clickedBranchLink) &&
          data[AppConstants.clickedBranchLink] == true) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EarnMoreScreen()));
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
    });
  }

  //To Setup Data For Generation Of Deep Link
  void initializeDeepLinkData() {
    buo = BranchUniversalObject(
      canonicalIdentifier: AppConstants.branchIoCanonicalIdentifier,
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata(
            AppConstants.deepLinkTitle, AppConstants.deepLinkData),
    );
    FlutterBranchSdk.registerView(buo: buo);

    lp = BranchLinkProperties();
    lp.addControlParam(AppConstants.controlParamsKey, '1');
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(cBanner);
    print("${userData.partnerId}");
    print("${userData.mobileNumber}");
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: TopBanner(),
                ),
                cBanner
                    ? SizedBox(
                        height: 16,
                      )
                    : Offstage(),
                cBanner
                    ? CongratulationsBanner(
                        pointsEarned: "50",
                        closeBanner: closeBanner,
                      )
                    : Offstage(),
                // Virtual Credit Card
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        VCreditCard(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.navigateTab(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Color(0XFF60C3AD),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color: Color(0XFF60C3AD),
                                    ),
                                  ),
                                  width: 140,
                                  height: 37,
                                  child: Center(
                                    child: Text(
                                      "VIEW DETAILS",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0XFF60C3AD),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  // onPressed: () {},
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          RedeemPointsScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF60C3AD),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  width: 140,
                                  height: 37,
                                  child: Center(
                                    child: Text(
                                      "REDEEM VIA CASH",
                                      style: TextStyle(
                                        fontSize: 12,
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
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // How Can You Earn
                      Text(
                        "How Can You Earn?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Why should you become a member",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      VideoPlayerSection(),
                      SizedBox(
                        height: 48,
                      ),
                      // Ways to Earn Points
                      Text(
                        "Ways To Earn Points",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "3 simple ways to boost your earnings",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Refer Other
                      ReferWaysTab(),
                      SizedBox(
                        height: 48,
                      ),
                      // Leaderboard Section Other
                      LeaderboardSection(
                        navigateTab: widget.navigateTab,
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      EarnmoreSection(buo: buo, lp: lp),
                    ],
                  ),
                ),
                Container(
                  color: Color(0XFFFAFBFB),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Your Unique Referral Code",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(bottom: 12.0, top: 10),
                            child: ShareReferral(
                              color: Colors.transparent,
                              referralCode: "${userData.referralCode}",
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          cBanner
              ? Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality
                        .explosive, // don't specify a direction, blast randomly
                    shouldLoop:
                        true, // start again as soon as the animation is finished
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // manually specify the colors to be used
                    // numberOfParticles: 100,
                  ),
                )
              : Offstage(),
        ],
      ),
    );
  }
}
