import 'package:nexus_app/model/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future saveNewApp() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.setBool('newApp', false);
// }

// Future getNewApp() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   bool newApp = preferences.getBool('newApp') != null
//       ? preferences.getBool('newApp')
//       : true;
//   return newApp;
// }

Future saveLogin(UserDataModel userDataModel) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userDataString = userDataModelToJson(userDataModel);
  await preferences.setString("userData", userDataString);
  // await preferences.setBool('newLogin', status);
  // await preferences.setBool('newApp', false);
  // await preferences.setString('uuid', uuid);
  // await preferences.setString('mobileNumber', mobileNumber);
  // await preferences.setString('name', name);
  // await preferences.setString('referral', referral);
}

Future saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString("userData", null);
  // await preferences.setBool('newLogin', true);
  // await preferences.setBool('newApp', true);
  // await preferences.setString('uuid', null);
  // await preferences.setString('mobileNumber', null);
  // await preferences.setString('name', null);
}

// Future getLogin() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   bool newLogin = preferences.getBool('newLogin') != null
//       ? preferences.getBool('newLogin')
//       : true;
//   return newLogin;
// }

Future<UserDataModel> getUserData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userDataString = preferences.getString('userData');
  UserDataModel userDataModel =
      userDataString != null ? userDataModelFromJson(userDataString) : null;
  return userDataModel;
}
