import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Network/Lead/leads_tab.dart';
import 'package:nexus_app/ui/Network/network_tab.dart';
import 'package:nexus_app/ui/Network/Partner/partners_tab.dart';
import 'package:nexus_app/ui/Widgets/appbar_points.dart';

class NetworkScreen extends StatefulWidget {
  @override
  _NetworkScreenState createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  String tabName = "Partners";
  changeTab() {
    print("YEs");
    if (tabName == "Partners") {
      setState(() {
        tabName = "Leads";
      });
    } else {
      setState(() {
        tabName = "Partners";
      });
    }
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback showPersBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    showPersBottomSheetCallBack = showBottomSheetPartner;
  }

  void showBottomSheetPartner() {
    setState(() {
      showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return new Container(
            height: 300.0,
            color: Colors.greenAccent,
            child: new Center(
              child: new Text("Hi BottomSheet"),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              showPersBottomSheetCallBack = showBottomSheetPartner;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("My Network"),
          actions: [
            AppbarPoints(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NetworkTab(
                tabName: tabName,
                changeTab: changeTab,
              ),
              tabName == "Partners" ? PartnersTab() : LeadsTab()
            ],
          ),
        ));
  }
}
