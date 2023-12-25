import 'package:flutter/material.dart';

class NetworkTab extends StatelessWidget {
  final String tabName;
  final Function changeTab;
  const NetworkTab({
    Key key,
    this.tabName,
    this.changeTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(tabName);
    return Padding(
      padding:
          const EdgeInsets.only(top: 24.0, bottom: 0, left: 16.0, right: 16.0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: Color(0XFFFAFBFB), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                height: 48,
                child: tabName == "Partners"
                    ? Card(
                        shape: new RoundedRectangleBorder(
                            side:
                                new BorderSide(color: Color(0XFF31C8AE), width: 0.1),
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.white,
                        margin: EdgeInsets.all(0),
                        child: Center(child: Text("Partners")),
                      )
                    : GestureDetector(
                        onTap: changeTab,
                        child: Container(
                          color: Colors.transparent,
                          height: 48,
                          child: Center(
                            child: Text(
                              "Partners",
                              style: TextStyle(color: Color(0XFF7A7D7E)),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: tabName == "Leads"
                    ? Card(
                        shape: new RoundedRectangleBorder(
                            side:
                                new BorderSide(color: Color(0XFF31C8AE), width: 0.1),
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.white,
                        child: Center(
                          child: Text("Leads"),
                        ),
                      )
                    : GestureDetector(
                        onTap: changeTab,
                        child: Container(
                          color: Colors.transparent,
                          height: 48,
                          child: Center(
                            child: Text(
                              "Leads",
                              style: TextStyle(color: Color(0XFF7A7D7E)),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
          ],
        ),
      ),
    );
  }
}
