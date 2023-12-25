import 'package:flutter/material.dart';

class NoUserFoundWidget extends StatelessWidget {
  
  final String searchText;
  const NoUserFoundWidget({
    Key key,
    @required this.searchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                // color: Color(0XFFF6F4F5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Image(
                          image: AssetImage(
                            "assets/no_user_found.png",
                          ),
                          height: 200.0,
                          width: 200.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        "No User Found",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "We couldn’t find anything to show for $searchText. Try adjusting your search to find what you are looking for.",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
