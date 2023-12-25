// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:nexus_app/model/lead_list_model.dart';
// import 'package:nexus_app/resources/http_requests.dart';
// import 'package:nexus_app/resources/variables.dart';
// import 'package:nexus_app/ui/Wallet/TransactionFilter/filter_screen_methods.dart';

// class FilterByLead extends StatefulWidget {
//   final List<String> currentIdList;
//   final Function(List<String>) idListChange;
//   const FilterByLead({
//     Key key,
//     @required this.currentIdList,
//     @required this.idListChange,
//   }) : super(key: key);

//   @override
//   _FilterByLeadState createState() => _FilterByLeadState();
// }

// class _FilterByLeadState extends State<FilterByLead> {
//   List<LeadListModel> leadList;
//   List<String> leadNameList = [];
//   List<String> leadIdList = [];
//   List<bool> lListBool = [];
//   bool selectAll = false;
//   List<String> leadFilterList = [];
//   String searchText;
//   // studentInfoData.data[index].name
//   //                           .toLowerCase()
//   //                           .contains(filter.toLowerCase())

//   Future<List<LeadListModel>> getLeadList() async {
//     var params = {
//       "brokerMobile": "${userData.mobileNumber}",
//       "searchTerm": "",
//       "status": ""
//     };
//     final response =
//         await ApiBase().get(context, "/mlm-service/searchLead", params, "");
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       List<LeadListModel> data = leadListModelFromJson(response.body);
//       setState(() {
//         leadList = data;
//         print(leadList.length);
//         for (int i = 0; i < leadList.length; i++) {
//           leadNameList.add(leadList[i].name);
//           leadIdList.add(leadList[i].phone);
//           lListBool.add(false);
//         }
//       });
//       return data;
//     } else {
//       return null;
//     }
//   }

//   alreadyAddedFilters() {
//     leadFilterList = widget.currentIdList;
//     for (int i = 0; i < leadFilterList.length; i++) {
//       if (leadIdList.contains(leadFilterList[i])) {
//         setState(() {
//           lListBool[leadIdList.indexOf(leadFilterList[i].toString())] = true;
//         });
//       }
//     }
//   }

//   @override
//   void initState() {
//     getLeadList().then((value) {
//       alreadyAddedFilters();
//       if (allTrue(lListBool)) {
//         setState(() {
//           selectAll = true;
//         });
//       }
//     });
//     super.initState();
//   }

//   changeAll(bool status) {
//     setState(() {
//       for (int i = 0; i < lListBool.length; i++) {
//         lListBool[i] = status;
//       }
//     });
//   }

//   createLeadFilterList() {
//     leadFilterList.clear();
//     for (int i = 0; i < lListBool.length; i++) {
//       if (lListBool[i] == true) {
//         leadFilterList.add(leadList[i].phone);
//       }
//     }
//     print(leadFilterList);
//     widget.idListChange(leadFilterList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (leadList != null) {
//       return Container(
//         // color: Colors.green,
//         // width: 135,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//               child: Container(
//                 height: 36,
//                 color: Color(0XFFFAFBFB),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(16, 2, 16, 6),
//                     suffixIcon: Icon(Icons.search, color: Color(0XFF4E5253)),
//                     hintText: "Search Lead",
//                     hintStyle:
//                         TextStyle(fontSize: 16, color: Color(0XFF7A7D7E)),
//                     border: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     disabledBorder: InputBorder.none,
//                   ),
//                   onChanged: (text) {
//                     setState(() {
//                       searchText = text;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 20,
//                     width: 20,
//                     child: Checkbox(
//                       value: selectAll,
//                       onChanged: (change) {
//                         setState(() {
//                           selectAll = change;
//                         });
//                         changeAll(change);
//                         createLeadFilterList();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("All"),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: leadNameList.length,
//                 itemBuilder: (context, index) {
//                   if (searchText == null || searchText == "") {
//                     return Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 20,
//                             width: 20,
//                             child: Checkbox(
//                               value: lListBool[index],
//                               onChanged: (change) {
//                                 setState(() {
//                                   lListBool[index] = change;
//                                   if (change && allTrue(lListBool)) {
//                                     selectAll = true;
//                                   } else {
//                                     selectAll = false;
//                                   }
//                                 });
//                                 createLeadFilterList();
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text("${leadNameList[index]}"),
//                           //  (${leadList[index].bookedOn})
//                         ],
//                       ),
//                     );
//                   } else if (leadList[index]
//                       .name
//                       .toLowerCase()
//                       .contains(searchText.toLowerCase())) {
//                     return Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 20,
//                             width: 20,
//                             child: Checkbox(
//                               value: lListBool[index],
//                               onChanged: (change) {
//                                 setState(() {
//                                   lListBool[index] = change;
//                                   if (change && allTrue(lListBool)) {
//                                     selectAll = true;
//                                   } else {
//                                     selectAll = false;
//                                   }
//                                 });
//                                 createLeadFilterList();
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text("${leadNameList[index]}"),
//                           //  (${leadList[index].bookedOn})
//                         ],
//                       ),
//                     );
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 72,
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   }
// }
