import 'package:flutter/material.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/bottom_navigation.dart';

class AppbarPoints extends StatelessWidget {
  const AppbarPoints({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Container(
          width: 67,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Color(0XFF60C3AD),
                ),
                width: 56,
                // height: 10,
                child: Center(
                  child: Text(
                    "$currentBalance",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0XFFFFFFFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: Color(0XFFFFFFFF),
                  child: Image.asset(
                    "assets/points.png",
                    height: 20,
                    width: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: (){HomeNavigationBar.homeNavigationState.navigationTapped(1);},
    );
  }
}
