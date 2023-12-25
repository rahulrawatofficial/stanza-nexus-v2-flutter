import 'dart:io';

import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Widgets/image_view.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Capitalize String
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }

//Get Version Name
Future<String> versionCheck(context) async {
  //Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  // double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
  print("!!${info.version}!!");
  return info.version.toString();
}

//Share Referral
Future<void> shareReferral() async {
  await FlutterShare.share(
    title: 'Nexus',
    text:
        'Hey! Use my referral code ${userData.referralCode} to pre-book online on https://www.stanzaliving.com/referral/${userData.referralCode}',
    linkUrl: "www.stanzaliving.com",
    chooserTitle: 'Nexus',
  );
}

//Open Email
void launchEmail(List<String> to) async {
  Email email = Email(to: to);
  await EmailLauncher.launch(email);
}

//Format Date

String dateValue(int date) {
  DateTime currentDate = DateTime.fromMillisecondsSinceEpoch(date);
  final DateFormat formatter1 = DateFormat("dd MMM");
  final DateFormat formatter2 = DateFormat("yy");
  final String formatted1 = formatter1.format(currentDate);
  final String formatted2 = formatter2.format(currentDate);
  final String formatted = "$formatted1' $formatted2";
  print(formatted);
  return formatted;
}

String dateValueMonth(int date) {
  DateTime currentDate = DateTime.fromMillisecondsSinceEpoch(date);
  final DateFormat formatter1 = DateFormat("MMM");
  final DateFormat formatter2 = DateFormat("yy");
  final String formatted1 = formatter1.format(currentDate);
  final String formatted2 = formatter2.format(currentDate);
  final String formatted = "$formatted1'$formatted2";
  print(formatted);
  return formatted;
}

String timeValue(int date) {
  DateTime currentTime = DateTime.fromMillisecondsSinceEpoch(date);
  final DateFormat formatter = DateFormat("jm");
  final String formatted = formatter.format(currentTime);
  print(formatted);
  return formatted;
}

List<DropdownMenuItem<String>> getDropDownMenuItems(List itemsList) {
  List<DropdownMenuItem<String>> items = new List();
  if (itemsList.length > 0) {
    for (String itemValue in itemsList) {
      items.add(new DropdownMenuItem(
          value: itemValue,
          child: new Text(
            itemValue,
            style: TextStyle(fontFamily: 'SourceSansPro'),
          )));
    }
    return items;
  } else {
    return [];
  }
}

showToast(String message) {
  Fluttertoast.showToast(
    msg: "$message",
    fontSize: 14.0,
  );
}

// void changedDropDownItemGender(String selectedGender) {
//     print("Selected soil $selectedGender, we are going to refresh the UI");
//     setState(() {
//       currentGender = selectedGender;
//     });
//   }

//Show Date Picker

// void launchStartDate() async {
//     dateSelected = await selectDateFromPicker();
//   }

Future<DateTime> selectDateFromPicker(
    BuildContext context, DateTime firstDate, DateTime dateSelected) async {
  DateTime cDate;
  cDate = await showDatePicker(
    context: context,
    initialDate: dateSelected,
    firstDate: firstDate != null
        ? firstDate
        : DateTime.fromMillisecondsSinceEpoch(userData.createdAt),
    lastDate: DateTime.now(),
  );

  if (cDate != null) {
    return cDate;
  } else {
    return dateSelected;
  }
}

Future getImageCameraSheet(BuildContext context) async {
  File croppedFile;
  var image = await ImagePicker().getImage(source: ImageSource.camera);
  if (image != null) {
    croppedFile = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.white,
      ),
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
    );
  }

  if (croppedFile != null) {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageView(
              imageFile: croppedFile,
              onConfirm: (file) {
                croppedFile = file;
              },
            )));
    if (croppedFile != null)
      return croppedFile;
    else
      return null;
  } else {
    return null;
  }
}

Future getImageGallerySheet(BuildContext context) async {
  File croppedFile;
  var image = await ImagePicker().getImage(source: ImageSource.gallery);

  if (image != null) {
    croppedFile = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.white,
      ),
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
    );
  }
  if (croppedFile != null) {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageView(
              imageFile: croppedFile,
              onConfirm: (file) {
                croppedFile = file;
              },
            )));
    if (croppedFile != null)
      return croppedFile;
    else
      return null;
  } else {
    return null;
  }
}

// Future getImageGallery() async {
//   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//   if (image != null) {
//     String imageFormat = image.path.split(".").last;
//     String imageName = image.path.split("/").last;
//     print(image.path);
//     print(imageFormat);
//     print(imageName);
//     Map imageData = {
//       "imageFile": image,
//       "imageFormat": imageFormat,
//       "imageName": imageName,
//     };
//     return imageData;
//   } else
//     return null;
// }

saveCropImage(String cropImageUrl) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString('cropImage', cropImageUrl);
}

getCropImage(String cropImageUrl) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var url = preferences.getString('cropImage');
  return url;
}

// Future<File> showBottomSheetImage(BuildContext context) async {
//   File imgFile;
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return new Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             new ListTile(
//               leading: new Icon(Icons.image),
//               title: new Text('Gallery'),
//               onTap: () {
//                 getImageGallerySheet().then((val) {
//                   imgFile = val;
//                 });
//               },
//             ),
//             new ListTile(
//               leading: new Icon(Icons.camera),
//               title: new Text('Camera'),
//               onTap: () {
//                 getImageGallerySheet().then((val) {
//                   imgFile = val;
//                 });
//               },
//             ),
//           ],
//         );
//       });
//   return imgFile;
// }

// Future<LocationData> getLocation() async {
//   Map<String, double> loc;
//   LocationData currentLocation;
//   var location = new Location();

//   try {
//     currentLocation = (await location.getLocation());
//     loc = {
//       "latitude": currentLocation.latitude,
//       "longitude": currentLocation.longitude,
//     };
//   } catch (e) {
//     currentLocation = null;
//   }
//   print(currentLocation.latitude);
//   return currentLocation;
// }

// Future<Address> getAddress() async {
//   Coordinates coordinates;
//   List<Address> address;
//   LocationData value = await getLocation();
//   coordinates = Coordinates(value.latitude, value.longitude);
//   address = await Geocoder.local.findAddressesFromCoordinates(coordinates);

//   // getLocation().then((val) async {
//   //   coordinates = Coordinates(val.latitude, val.longitude);
//   //   address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   // });
//   return address[0];
//   // print(address[0].subLocality);
// }
