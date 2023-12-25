// import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';
// import 'package:path_provider/path_provider.dart';

class ShareReferral extends StatelessWidget {
  @required
  final Color color;
  @required
  final String referralCode;
  const ShareReferral({
    Key key,
    this.color,
    this.referralCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //write to app path
    // Future<void> writeToFile(ByteData data, String path) {
    //   final buffer = data.buffer;
    //   return new File(path).writeAsBytes(
    //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    // }

    // Future<void> shareFile() async {
    //   //read and write
    //   final filename = 'logo.png';
    //   var data = await rootBundle.load("assets/logo.png");
    //   List<int> bytes =
    //       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //   String dir = (await getApplicationDocumentsDirectory()).path;
    //   await File('$dir/$filename').writeAsBytes(bytes);
    //   // writeToFile(bytes, '$dir/$filename').then((value) async {
    //   await FlutterShare.shareFile(
    //     title: 'Nexus',
    //     text:
    //         'Hey! Use my referral code {referral_code} to pre-book online on https://www.stanzaliving.com/referral/ {referral_code}',
    //     filePath: '$dir/$filename',
    //   );
    //   // });
    // }

    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
              // border: Border.all(
              //   color: Color(0XFF60C3AD),
              // ),
            ),
            // width: 148,
            height: 48,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(4.0),
              padding: EdgeInsets.all(0),
              dashPattern: [5],
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: referralCode))
                        .then((value) {
                      Fluttertoast.showToast(msg: "Copied to Clipboard");
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          referralCode,
                          style: TextStyle(
                            // color: Color(0XFF60C3AD),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: 24,
                          width: 1,
                          color: Colors.grey,
                        ),
                        Icon(Icons.copy),
                        Text(
                          "COPY",
                          style: TextStyle(
                            // color: Color(0XFF60C3AD),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              shareReferral();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFF60C3AD),
                borderRadius: BorderRadius.circular(4.0),
              ),
              // width: 148,
              height: 48,
              child: Center(
                child: Text(
                  "SHARE",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
