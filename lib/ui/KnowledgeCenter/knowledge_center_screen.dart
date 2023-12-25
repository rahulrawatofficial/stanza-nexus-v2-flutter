import 'package:flutter/material.dart';
import 'package:nexus_app/ui/KnowledgeCenter/faq_screen.dart';
import 'package:nexus_app/ui/KnowledgeCenter/support_screen.dart';
import 'package:nexus_app/ui/KnowledgeCenter/terms_and_condition_screen.dart';

class KnowledgeCenterScreen extends StatefulWidget {
  @override
  _KnowledgeCenterScreenState createState() => _KnowledgeCenterScreenState();
}

class _KnowledgeCenterScreenState extends State<KnowledgeCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Knowledge Center"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 24.0,
                // ),
                KnowledgeCenterTile(
                  title: "FAQ",
                  subTitle: "Frequently asked questions",
                  iconAsset: "assets/faq.png",
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FaqScreen()));
                  },
                ),
                KnowledgeCenterTile(
                  title: "Terms & Conditions",
                  subTitle: "Document is an electronic record",
                  iconAsset: "assets/t&c.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TermsAndConditionScreen()));
                  },
                ),
                KnowledgeCenterTile(
                  title: "Support",
                  subTitle: "Send your query via email",
                  iconAsset: "assets/support.png",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SupportScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KnowledgeCenterTile extends StatelessWidget {
  @required
  final String iconAsset;
  @required
  final String title;
  @required
  final String subTitle;
  @required
  final Function onTap;
  const KnowledgeCenterTile({
    Key key,
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
              borderRadius: BorderRadius.circular(4.0),
              color: Color(0XFFEDF4FF)),
          // color: color,
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
