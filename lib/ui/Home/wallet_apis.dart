import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';

Future getWalletDetails(BuildContext context) async {
  var params = {"partnerId": "${userData.partnerId}"};
  final response = await ApiBase()
      .get(context, "/mlm-service/getWalletDetailsByPartnerId", params, "");
  print(response.statusCode);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    currentBalance = data["currentBalance"].toInt();
    // widget.currentPoints(data["currentBalance"].toInt());
    return data;
  } else {
    return null;
  }
}

Future getConversionRate(BuildContext context) async {
  var params = {"partnerId": "${userData.partnerId}"};
  final response = await ApiBase()
      .get(context, "/mlm-service/getConversionRate", params, "");
  print(response.statusCode);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    conversionRate = data["rate"];
    return data;
  } else {
    return null;
  }
}
