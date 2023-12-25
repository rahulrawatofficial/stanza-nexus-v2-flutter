// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

// Future<dynamic> uploadPanDetailsAd(
//   BuildContext context,
//   File imageFile,
//   String brokerMobile,
//   String panHolderName,
//   String panNumber,
//   String partnerId,
// ) async {
//   var path = "/inventory/nexusV2/broker/document/pan";
//   var url = Uri(
//     scheme: "https",
//     host: "adhocinventory.stanzaliving.com",
//     port: null,
//     path: path,
//   );

//   // upload(File imageFile) async {
//   var imageData;
//   var stream = http.ByteStream.fromBytes(imageFile.readAsBytesSync());
//   var length = await imageFile.length();

//   var uri = url;

//   var request = new http.MultipartRequest("POST", uri);
//   request.fields["brokerMobile"] = brokerMobile;
//   request.fields['panHolderName'] = panHolderName;
//   request.fields['panNumber'] = panNumber;
//   request.fields['partnerId'] = partnerId;

//   var multipartFile = new http.MultipartFile('file', stream, length,
//       filename: basename(imageFile.path));

//   request.headers.addAll({
//     "authorization": "Bearer " +
//         "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyMDIwMjAyMDcwIiwic2NvcGVzIjpbIkJST0tFUiJdLCJpc3MiOiIiLCJpYXQiOjE2MDY4MDU2NjQsImV4cCI6MTYzODM0NTY2NH0.SrSsbKj24H6ctdPe4C-dd_ClfX9IQ4VMA2IA_D7x8F4skOyGHbMjl5NWXJTop8JH0dLSRhE69E0pqPUBLQZyyA"
//   });
//   request.files.add(multipartFile);
//   try {
//     var response = await request.send();
//     print(response.statusCode);
//     response.stream.transform(utf8.decoder).listen((value) async {
//       print(value);
//       var data = await json.decode(value);
//       imageData = data;
//       if (response.statusCode != 200) {}
//       print(data["id"]);
//     });
//     return imageData;
//   } catch (e) {
//     print("Error");

//     return "Error";
//   }
// }
