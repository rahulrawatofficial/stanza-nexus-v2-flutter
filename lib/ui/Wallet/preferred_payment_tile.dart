import 'package:flutter/material.dart';

class PreferredPayment extends StatefulWidget {
  final bool preferred;
  final String title;
  final String subtitle;
  final Widget radioButton;
  const PreferredPayment({
    Key key,
    this.title,
    this.subtitle,
    this.radioButton,
    @required this.preferred,
  }) : super(key: key);

  @override
  _PreferredPaymentState createState() => _PreferredPaymentState();
}

class _PreferredPaymentState extends State<PreferredPayment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Color(0XFFF6F4F5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    child: widget.radioButton,
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: MediaQuery.of(context).size.width - 96,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.title}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("${widget.subtitle}", style: TextStyle())
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            widget.preferred
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Color(0XFFFAB432),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          13, 3, 13, 3),
                                      child: Text(
                                        "PREFERRED",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Offstage(),
                            SizedBox(
                              height: 8,
                            ),
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.green,
                              size: 16,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
