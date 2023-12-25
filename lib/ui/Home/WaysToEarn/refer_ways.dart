import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Home/WaysToEarn/complete_task.dart';
import 'package:nexus_app/ui/Home/WaysToEarn/refer_lead.dart';
import 'package:nexus_app/ui/Home/WaysToEarn/refer_partner.dart';

class ReferWaysTab extends StatefulWidget {
  const ReferWaysTab({
    Key key,
  }) : super(key: key);

  @override
  _ReferWaysTabState createState() => _ReferWaysTabState();
}

class _ReferWaysTabState extends State<ReferWaysTab> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = 0;
                });
              },
              child: TabHead(
                assetName: "assets/lead.png",
                title: "Refer a \nLead",
                active: activeIndex == 0 ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = 1;
                });
              },
              child: TabHead(
                assetName: "assets/partner.png",
                title: "Refer a \nPartner",
                active: activeIndex == 1 ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = 2;
                });
              },
              child: TabHead(
                assetName: "assets/task.png",
                title: "Complete Tasks",
                active: activeIndex == 2 ? true : false,
              ),
            ),
          ],
        ),
        // activeTab(activeIndex),
        activeIndex == 0
            ? ReferLead()
            : activeIndex == 1
                ? ReferPartner()
                : CompleteTask(),
      ],
    );
  }
}

class TabHead extends StatelessWidget {
  @required
  final String assetName;
  final String title;
  final bool active;
  const TabHead({
    Key key,
    this.assetName,
    this.title,
    this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? Color(0XFFEDF4FF) : Color(0XFFFFFFFF),
        border: active
            ? null
            : Border.all(
                color: Color(0XFF7A7D7E),
                width: 0.5,
              ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      height: active ? 92 : 84,
      width: (MediaQuery.of(context).size.width - 32) / 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              assetName,
              fit: BoxFit.fill,
              height: 24,
              width: 24,
            ),
            Text(
              title,
              style: TextStyle(
                color: Color(0XFF7A7D7E),
              ),
            )
          ],
        ),
      ),
    );
  }
}
