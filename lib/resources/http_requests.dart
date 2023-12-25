import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:nexus_app/resources/error_alert.dart';

class ApiBase {
  String scheme = "https";
  // String host = "96ba40b53367.ngrok.io";
  String host = "preproderp.stanzaliving.com"; //live
 // String host = "fb78ea7e8519.ngrok.io";
  int port;
  ErrorAlert _errorAlert = ErrorAlert();

  List serviceList = List();

  // addServie() {
  //   serviceList.add("/api/getAgentUsersList");
  //   serviceList.add("/api/getFamilyMembersNew");
  //   serviceList.add("/api/getUserLandDetails");
  //   serviceList.add("/api/getFarmerExtraDetail");
  //   serviceList.add("/api/getAgentVillageList");
  //   serviceList.add("/api/getFarmerListOfVillage");
  //   serviceList.add("/api/getUserReportHistoryResponseListByKhasra");
  //   serviceList.add("/api/getMilkingAnimalDetails");
  //   serviceList.add("/api/getBeekeepingDetails");
  //   serviceList.add("/api/getUserCropListByKhasraNo");
  //   serviceList.add("/api/getGovernmentSchemesList");
  //   serviceList.add("/api/getUserSubsidies");
  //   serviceList.add("/api/searchUsers");
  //   serviceList.add("/api/sendOTPFarmerVerification");
  //   serviceList.add("/api/verifyOTPFarmerVerification");
  //   serviceList.add("/api/getFarmersDataQuantitativeAnalysis");
  //   serviceList.add("/api/storeFarmersDataQuantitativeAnalysis");
  //   serviceList.add("/api/storeFarmerExtraDetail");
  //   serviceList.add("/api/checkLocationForLandMap");
  //   serviceList.add("/api/getRelationships");
  //   serviceList.add("/api/addUserForAgent");
  //   serviceList.add("/api/getSoilsByDistrict");
  //   serviceList.add("/api/getSourceOfIrrigation");
  //   serviceList.add("/api/addFamilyMemberHealthDetails");
  //   serviceList.add("/api/addFamilyMemberNew");
  //   serviceList.add("/api/addUserLandDetail");
  //   serviceList.add("/api/getMoveableEquipments");
  //   serviceList.add("/api/getImmoveableEquipments");
  //   serviceList.add("/api/getSubsidies");
  //   serviceList.add("/api/addMilkingAnimalDetails");
  //   serviceList.add("/api/storeBeekeepingDetails");
  //   serviceList.add("/api/addUserEquipment");
  //   serviceList.add("/api/storeUserSubsidy");
  //   serviceList.add("/api/getGovernmentSchemesList");
  //   serviceList.add("/api/storeUserSchemeList");
  //   serviceList.add("/api/storeFarmerExtraDetail");
  // }

  Map<String, String> authHeader = {
    "Content-Type": "application/json",
  };

  Future<dynamic> get(BuildContext context, String serviceName,
      Map<String, dynamic> params, String userTokenNew) async {
    // addServie();
    var responseJson;

    if (serviceList.contains(serviceName)) {
      authHeader.putIfAbsent("Authorization", () => "Bearer $userTokenNew");
      print(authHeader);
    }
    print(params);
    try {
      final response = await http.get(
        Uri(
          scheme: scheme,
          host: host,
          port: port,
          path: serviceName,
          queryParameters: params != null ? params : null,
        ),
        headers: authHeader,
      );
      responseJson = _returnResponse(context, response);
    } on SocketException {
      // ErrorAlert().showErrorDailog(context, "Network Error",
      //     "Check your internet connection", null, false);
      return responseJson;
    }
    return responseJson;
  }

  Future<dynamic> post(BuildContext context, String serviceName, var params,
      dynamic body, String userTokenNew) async {
    print(serviceName);
    var responseJson;
    print(Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: serviceName,
      queryParameters: params != null ? params : null,
    ).toString());
    if (serviceList.contains(serviceName)) {
      authHeader.putIfAbsent("Authorization", () => "Bearer $userTokenNew");
      print(authHeader);
    }
    try {
      final response = await http.post(
        Uri(
          scheme: scheme,
          host: host,
          port: port,
          path: serviceName,
          queryParameters: params != null ? params : null,
        ),
        body: json.encode(body),
        headers: authHeader,
      );
      print("###${json.encode(body)}###");
      print(response.statusCode);
      print(response.body);
      responseJson = _returnResponse(context, response);
    } on SocketException {
      _errorAlert.showErrorDailog(context, "Network Error",
          "Check your internet connection", null, false);
      return responseJson;
    }
    return responseJson;
  }

  Future<dynamic> put(BuildContext context, String serviceName, Map params,
      String userTokenNew) async {
    // addServie();
    var responseJson;
    if (serviceList.contains(serviceName)) {
      authHeader.putIfAbsent("Authorization", () => "$userTokenNew");
    }
    try {
      final response = await http.put(
        Uri(
          scheme: scheme,
          host: host,
          port: port,
          path: serviceName,
          queryParameters: params != null ? params : null,
        ),
        // body: json.encode(body),
        headers: authHeader,
      );
      print(response.statusCode);
      print(response.body);
      responseJson = _returnResponse(context, response);
    } on SocketException {
      _errorAlert.showErrorDailog(context, "Network Error",
          "Check your internet connection", null, false);
    }
    return responseJson;
  }

  Future<dynamic> delete(BuildContext context, String serviceName, Map params,
      String userToken) async {
    var responseJson;
    if (serviceList.contains(serviceName)) {
      authHeader.putIfAbsent("Authorization", () => "Bearer $userToken");
    }
    try {
      final response = await http.delete(
        Uri(
          scheme: scheme,
          host: host,
          port: port,
          path: serviceName,
          queryParameters: params != null ? params : null,
        ),
        headers: authHeader,
      );
      responseJson = _returnResponse(context, response);
    } on SocketException {
      _errorAlert.showErrorDailog(context, "Network Error",
          "Check your internet connection", null, false);
    }
    return responseJson;
  }

  http.Response _returnResponse(BuildContext context, http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        print(responseJson);
        return response;
      case 400:
        print(response.body);
        // var d = json.decode(response.body);
        // String errorMessage =
        //     d["errorMessage"] != null ? d["errorMessage"] : "Data not found";
        // _errorAlert.showErrorDailog(context, "", errorMessage, null, false);
        return response;
      case 409:
        print(response.body);
        // var d = json.decode(response.body);
        // String errorMessage =
        //     d["errorMessage"] != null ? d["errorMessage"] : "Data not found";
        // _errorAlert.showErrorDailog(context, "", errorMessage, null, false);
        return response;
      case 401:
        print(response.body);
        // _errorAlert.showErrorDailog(
        //     context, "Unauthorized", "You are Unauthorized", null, false);
        return response;
      case 403:
        print(response.body);
        // _errorAlert.showErrorDailog(
        //     context, "Unauthorized", "You are Unauthorized", null, false);
        return response;
      case 500:
      default:
        // _errorAlert.showErrorDailog(
        //     context, "Connection", "No Connection found", null, false);
        return response;
    }
  }
}
