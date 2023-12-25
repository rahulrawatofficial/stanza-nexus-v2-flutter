import 'package:flutter/material.dart';

class FilterTab extends StatelessWidget {
  final String title;
  final bool currentTab;
  final Function(String) changeTab;
  const FilterTab({
    Key key,
    @required this.title,
    @required this.currentTab,
    this.changeTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeTab(title);
      },
      child: Container(
        color: currentTab ? Color(0XFFF6F4F5) : Colors.white,
        height: 48,
        width: 140,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 13, 9, 15),
          child: Text("$title"),
        ),
      ),
    );
  }
}
