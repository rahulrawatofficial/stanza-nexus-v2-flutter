import 'package:flutter/material.dart';
import 'package:nexus_app/model/lead_list_model.dart';
import 'package:nexus_app/ui/Network/Lead/lead_info_sheet.dart';

Color statusColor(status) {
  if (status == "BOOKED") {
    return Color(0XFF60C3AD);
  }
  if (status == "PRE_BOOKED") {
    return Color(0XFF5FC4F5);
  }
  if (status == "DISQUALIFIED") {
    return Color(0XFFF55F71);
  }
  if (status == "IN_PROGRESS") {
    return Color(0XFFFFB701);
  } else {
    return Color(0XFFFFB701);
  }
}

String statusName(status) {
  if (status == "BOOKED") {
    return "BOOKED";
  }
  if (status == "PRE_BOOKED") {
    return "PRE-BOOKED";
  }
  if (status == "DISQUALIFIED") {
    return "DISQUALIFIED";
  }
  if (status == "IN_PROGRESS") {
    return "IN PROGRESS";
  } else {
    return "IN PROGRESS";
  }
}

bottomSheetPartnerInfo(BuildContext context, LeadListModel partnerData) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white, // or some other color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: LeadInfoSheet(
              context: context,
              leadData: partnerData,
            ),
          ),
        );
      });
}
