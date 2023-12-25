import 'package:flutter/material.dart';
import 'package:nexus_app/model/kyc_detail_model.dart';
import 'package:nexus_app/ui/KYCDetails/id_details_screen.dart';
import 'package:nexus_app/ui/KYCDetails/kyc_details_screen.dart';
import 'package:nexus_app/ui/KYCDetails/kyc_screen_widgets.dart';
import 'package:nexus_app/ui/KYCDetails/payment_method_screen.dart';
import 'package:nexus_app/ui/Wallet/preferred_payment_tile.dart';

class PaymentMethodSection extends StatefulWidget {
  final Function(String) onChange;
  final Function reload;
  final KycDetailModel kycData;
  const PaymentMethodSection({
    Key key,
    @required this.onChange,
    @required this.kycData,
    @required this.reload,
  }) : super(key: key);

  @override
  _PaymentMethodSectionState createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String groupValue;
  var data;

  @override
  void initState() {
    print("__${widget.kycData.preferredPaymentMode}__");
    groupValue = widget.kycData.preferredPaymentMode;
    widget.onChange(groupValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Method",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              "Tap on the payment method card to select",
              style: TextStyle(),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        widget.kycData.paytmNumber != null
            ? PreferredPayment(
                preferred: widget.kycData.preferredPaymentMode == "PAYTM"
                    ? true
                    : false,
                title: "Paytm",
                subtitle: "+91-3514057267",
                radioButton: Radio(
                  groupValue: groupValue,
                  value: "PAYTM",
                  onChanged: (_) {
                    setState(() {
                      groupValue = _;
                      widget.onChange(_);
                    });
                  },
                ),
              )
            : Offstage(),
        widget.kycData.accountNumber != null
            ? PreferredPayment(
                preferred: widget.kycData.preferredPaymentMode == "BANKTRANSFER"
                    ? true
                    : false,
                title: "Bank Account",
                subtitle: "201821347192021 (Kotak Mah…)",
                radioButton: Radio(
                  groupValue: groupValue,
                  value: "BANKTRANSFER",
                  onChanged: (_) {
                    setState(() {
                      groupValue = _;
                      widget.onChange(_);
                    });
                  },
                ),
              )
            : Offstage(),
        widget.kycData.vpaAddress != null
            ? PreferredPayment(
                preferred:
                    widget.kycData.preferredPaymentMode == "VPA" ? true : false,
                title: "UPI",
                subtitle: "3514057267@upi",
                radioButton: Radio(
                  groupValue: groupValue,
                  value: "VPA",
                  onChanged: (_) {
                    setState(() {
                      groupValue = _;
                      widget.onChange(_);
                    });
                  },
                ),
              )
            : Offstage(),
        widget.kycData.paytmNumber == null &&
                widget.kycData.accountNumber == null &&
                widget.kycData.vpaAddress == null &&
                widget.kycData.panNumber == null
            ? Offstage()
            : widget.kycData.paytmNumber != null &&
                    widget.kycData.accountNumber != null &&
                    widget.kycData.vpaAddress != null
                ? Offstage()
                : InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentMethodScreen(
                                reload: widget.reload,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color(0XFF60C3AD),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Color(0XFF4E5253),
                        ),
                      ),
                      height: 36,
                      child: Center(
                        child: Text(
                          "ADD NEW PAYMENT METHOD",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0XFF4E5253),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // onPressed: () {},
                    ),
                  ),
        // widget.kycData.paytmNumber != null &&
        //         widget.kycData.accountNumber != null &&
        //         widget.kycData.vpaAddress != null
        //     ? Offstage()
        //     : SizedBox(
        //         height: 80,
        //       ),
        widget.kycData.paytmNumber == null &&
                widget.kycData.accountNumber == null &&
                widget.kycData.vpaAddress == null &&
                widget.kycData.panNumber == null
            ? KYCTile(
                color: Color(0XFFEDF4FF),
                title: "KYC Complete",
                subTitle:
                    "Complete the details to ensure that you receive the referral amount.",
                iconAsset: "assets/id.png",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KycDetailsScreen(
                            reload: widget.reload,
                          )));
                },
              )
            : Offstage(),
        SizedBox(
          height: 16,
        ),
        widget.kycData.paytmNumber == null &&
                widget.kycData.accountNumber == null &&
                widget.kycData.vpaAddress == null &&
                widget.kycData.panNumber == null
            ? Offstage()
            : widget.kycData.panNumber == null
                ? Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      KYCTile(
                        color: Color(0XFFEDF4FF),
                        title: "Upload PAN Card",
                        subTitle:
                            "Upload PAN card to be a verified partner and lower your TDS",
                        iconAsset: "assets/id.png",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => IdDetailsScreen(
                                    reload: widget.reload,
                                  )));
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                : Offstage(),
      ],
    );
  }
}
