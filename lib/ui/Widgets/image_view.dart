import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final File imageFile;
  final Function(File) onConfirm;

  const ImageView({Key key, this.imageFile, this.onConfirm}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  File image;

  @override
  void initState() {
    image = widget.imageFile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF232728),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 337,
            color: Color(0XFF232728),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    File(image.path),
                    width: 335.0,
                    height: 187.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Is the front of your ID clear?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "The photo should clearly show the front of your ID - nothing blurry or cut off, and no glare.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.onConfirm(null);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Color(0XFF60C3AD),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Color(0XFF60C3AD),
                            ),
                          ),
                          width: 163,
                          height: 48,
                          child: Center(
                            child: Text(
                              "TRY AGAIN",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0XFF60C3AD),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          // onPressed: () {},
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.onConfirm(image);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF60C3AD),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          width: 163,
                          height: 48,
                          child: Center(
                            child: Text(
                              "LOOK GOOD",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          // onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
