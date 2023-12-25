import 'package:flutter/material.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height - 112,
                color: Color(0XFFDDF2F5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Image(
                          image: AssetImage(
                            "assets/support_image.png",
                          ),
                          height: 200.0,
                          width: 200.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        "Tell Us How We Can Help",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "We are constantly striving to improve and we’d love to get your feedback. You can drop us an email at:",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.0),
                      InkWell(
                        onTap: () {
                          launchEmail(["help@stanzaliving.com"]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF60C3AD),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          height: 48,
                          width: MediaQuery.of(context).size.width - 64,
                          child: Center(
                            child: Text(
                              "help@stanzaliving.com",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                // fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          // onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

