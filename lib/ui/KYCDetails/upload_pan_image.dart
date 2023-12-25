import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<dynamic> uploadPanDetails(
  BuildContext context,
  File imageFile,
  String brokerMobile,
  String panHolderName,
  String panNumber,
  String partnerId,
) async {
  var imageData;
  var path = "/mlm-service/uploadPanDetails";
  var url = Uri(
    scheme: "https",
    // host: "96ba40b53367.ngrok.io",
    host: "preproderp.stanzaliving.com", //live
    port: null,
    path: path,
  );

  // upload(File imageFile) async {
  var stream = http.ByteStream.fromBytes(imageFile.readAsBytesSync());
  var length = await imageFile.length();

  var uri = url;

  var request = new http.MultipartRequest("POST", uri);
  request.fields["brokerMobile"] = brokerMobile;
  request.fields['panHolderName'] = panHolderName;
  request.fields['panNumber'] = panNumber;
  request.fields['partnerId'] = partnerId;

  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  request.files.add(multipartFile);
  try {
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      var data = await json.decode(value);
      imageData = data;
      print(data);
      if (response.statusCode != 200) {}
      print(data["fileName"]);
    });

    return imageData;
  } catch (e) {
    print("Error");
    return "Error";
  }
}
