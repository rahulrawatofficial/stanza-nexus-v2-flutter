import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/local_data.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/bottom_navigation.dart';
import 'package:nexus_app/ui/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUserData().then((localUserData) {
      userData = localUserData;
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  localUserData != null ? HomeNavigationBar() : Onboarding())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/splash_img.png',
          height: 150.0,
          width: 150.0,
        ),
      ),
    );
  }
}
