import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Home/home_screen.dart';
import 'package:nexus_app/ui/Leaderboard/leaderboard_screen.dart';
import 'package:nexus_app/ui/Network/network_screen.dart';
import 'package:nexus_app/ui/Profile/profile_screen.dart';
import 'package:nexus_app/ui/Wallet/wallet_screen.dart';

class HomeNavigationBar extends StatefulWidget {
    static _HomeNavigationBarState homeNavigationState;
 
   HomeNavigationBar({
    Key key,
  }) : super(key: key);

  
  @override
  _HomeNavigationBarState createState() {
     homeNavigationState =_HomeNavigationBarState();
     return homeNavigationState;
  }
}

class _HomeNavigationBarState extends State<HomeNavigationBar>
    with SingleTickerProviderStateMixin {
      
  String title = "Annadata MarketPlace";
  Color titleColor = Color(0xFF009D37);
  Color buttonColor = Color(0xFF0047C4);

  bool dkdProducts = false;
   TabController tabController;
  String location = "Location";

   void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    tabController.animateTo(page);
    // tabController.animateToPage(page,
    //     duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 1,
      //   // backgroundColor: Colors.white,
      //   title: Row(
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.only(right: 8.0),
      //         child: Image.asset(
      //           "assets/appbar-logo.png",
      //           height: 35,
      //         ),
      //       ),
      //       Text(
      //         "Y",
      //         textAlign: TextAlign.start,
      //         // style: TextStyle(color: titleColor, fontSize: 18),
      //       ),
      //     ],
      //   ),
      //   centerTitle: false,
      //   actions: <Widget>[],
      // ),
      body: Column(
        // Column
        children: <Widget>[
          Expanded(
            flex: 5,
            child: TabBarView(
              // Tab Bar View
              physics: BouncingScrollPhysics(),
              controller: tabController,
              children: <Widget>[
                HomeScreen(
                  navigateTab: navigationTapped,
                ),
                WalletScreen(),
                NetworkScreen(),
                LeaderBoardScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          Container(
            color: Theme.of(context)
                .scaffoldBackgroundColor, // Tab Bar color change
            child: TabBar(
              // TabBar

              controller: tabController,
              unselectedLabelColor: Color(0XFF7A7D7E),
              // unselectedLabelColor: Color(0xFFFFA100),
              labelColor: Color(0xFF60C3AD),
              // indicatorWeight: 1,
              labelStyle: TextStyle(fontSize: 12),
              unselectedLabelStyle:
                  TextStyle(fontSize: 12, color: Color(0XFF7A7D7E)),
              indicatorColor: Color(0xFF60C3AD),
              labelPadding: EdgeInsets.all(0),

              tabs: <Widget>[
                Tab(
                  text: "Home",
                  icon: Icon(
                    Icons.home,
                    size: 20,
                  ),
                ),
                Tab(
                  text: "Wallet",
                  icon: Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 20,
                  ),
                ),
                Tab(
                  text: "Network",
                  icon: Icon(
                    Icons.people_alt,
                    size: 20,
                  ),
                ),
                Tab(
                  text: "Leaderboard",
                  icon: Icon(
                    Icons.leaderboard,
                    size: 20,
                  ),
                ),
                Tab(
                  text: "Profile",
                  icon: Icon(
                    Icons.person_outline_rounded,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
