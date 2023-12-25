import 'package:flutter/material.dart';
import 'package:nexus_app/model/lead_list_model.dart';
import 'package:nexus_app/model/partner_list_model.dart';
import 'package:nexus_app/resources/http_requests.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Network/Lead/lead_methods.dart';
import 'package:nexus_app/ui/Network/Lead/leader_card.dart';
import 'package:nexus_app/ui/Network/Partner/partner_card.dart';
import 'package:nexus_app/ui/Network/no_user_found_widget.dart';

class SearchPartnerScreen extends StatefulWidget {
  @override
  _SearchPartnerScreenState createState() => _SearchPartnerScreenState();
}

class _SearchPartnerScreenState extends State<SearchPartnerScreen> {
  String searchText = "";
  var _controller = TextEditingController();

  Future<List<PartnerListModel>> getPartnerList() async {
    var params = {
      "partnerId": "${userData.partnerId}",
      "searchText": searchText,
    };
    final response = await ApiBase().get(context,
        "/mlm-service/getPartnersReferredPartnerTransactionList", params, "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<PartnerListModel> data = partnerListModelFromJson(response.body);
      return data;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 36,
          // width: 411,
          color: Color(0XFFFAFBFB),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(16, 2, 16, 6),
              suffixIcon: _controller.text.toString() == ""
                  ? Icon(Icons.search, color: Color(0XFF4E5253))
                  : IconButton(
                      onPressed: () => {
                        setState(
                          () {
                            searchText = "";
                            _controller.clear();
                          },
                        ),
                      },
                      icon: Icon(Icons.clear, color: Color(0XFF4E5253)),
                    ),
              hintText: "Search Partner",
              hintStyle: TextStyle(fontSize: 16, color: Color(0XFF7A7D7E)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                searchText = text;
              });
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPartnerList(),
        builder: (context, AsyncSnapshot<List<PartnerListModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.length > 0) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PartnersCard(
                      title: snapshot.data[index].name,
                      amount: snapshot.data[index].transactionPoints,
                      referrals: snapshot.data[index].referralCount,
                      imageUrl: snapshot.data[index].image,
                      onTap: () {
                        // bottomSheetPartnerInfo(snapshot.data[index]);
                      },
                    );
                  },
                ),
              );
            } else {
              return NoUserFoundWidget(
                searchText: searchText,
              );
            }
          }
        },
      ),
    );
  }
}
