import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_app/model/user_data_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/local_data.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Profile/user_avatar.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool loading = false;
  String selectedAsset = userData.imageUrl;
  bool userNameExist = false;

  TextEditingController userNameController =
      TextEditingController(text: "${userData.username}");

  //On CheckUsername
  Future checkUserName() async {
    var param = {"username": userNameController.text};
    ApiBase()
        .get(context, "/mlm-service/internal/checkUsernameExist", param, null)
        .then((value) {
      // setState(() {
      //   loading = false;
      // });
      print(value.statusCode);
      if (value.statusCode == 409) {
        setState(() {
          userNameExist = true;
        });
      } else {
        setState(() {
          userNameExist = false;
        });
      }
    });
  }

  @override
  void initState() {
    //Listener
    userNameController.addListener(() {
      setState(() {
        checkUserName();
      });
    });
    super.initState();
  }

  List assetList = [
    "assets/Avatar/user1.png",
    "assets/Avatar/user2.png",
    null,
    "assets/Avatar/user3.png",
    "assets/Avatar/user4.png"
  ];

  updateProfile() async {
    var body = {
      "imageUrl": selectedAsset,
      "partnerId": "${userData.partnerId}",
      "username": userNameController.text,
    };
    setState(() {
      loading = true;
    });
    var response = await ApiBase()
        .post(context, "/mlm-service/updatePartnerProfile", null, body, null);
    setState(() {
      loading = false;
    });
    if (response.statusCode == 200) {
      userData = userDataModelFromJson(response.body);
      saveLogin(userData).then((value) {
        showToast("Profile Updated");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Details",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0XFF232728),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "View your personal details as this will be used across the account.",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              hintText: "Select Username",
                              hintStyle: TextStyle(
                                color: Color(0XFF7A7D7E),
                              ),
                              suffixIcon: userNameController.text.length == 0
                                  ? Offstage()
                                  : userNameExist
                                      ? Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.lightGreen,
                                        ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Choose Avatar",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 77,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                                  List.generate(assetList.length, (index) {
                                return Container(
                                  // height: 70,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedAsset = assetList[index];
                                      });
                                    },
                                    child: UserAvatar(
                                      enabled: selectedAsset == assetList[index]
                                          ? true
                                          : false,
                                      assetName: assetList[index],
                                      radius: index == 2 ? 32 : 26,
                                      name: "${userData.name}",
                                    ),
                                  ),
                                  // child: Stack(
                                  //   children: [
                                  //     UserAvatar(
                                  //       assetName: assetList[index],
                                  //       radius: index == 2 ? 32 : 26,
                                  //       name: userName,
                                  //     ),
                                  //     index == 2
                                  //         ? Positioned(
                                  //             left: 18,
                                  //             top: 46,
                                  //             child: CircleAvatar(
                                  //               radius: 12,
                                  //               child: Icon(
                                  //                 Icons.edit_outlined,
                                  //                 color: Colors.white,
                                  //                 size: 18,
                                  //               ),
                                  //             ),
                                  //           )
                                  //         : Offstage()
                                  //   ],
                                  // ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${userData.name}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Mobile Number",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${userData.mobileNumber}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${userData.email}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "City",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0XFF232728),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${userData.city}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0XFF232728),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                disabledColor: Color(0XFFA5A9A9),
                                color: Color(0XFF31C8AE),
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: userNameExist
                                    ? null
                                    : () {
                                        updateProfile();
                                      },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            loading ? Center(child: CircularProgressIndicator()) : Offstage()
          ],
        ),
      ),
    );
  }
}
