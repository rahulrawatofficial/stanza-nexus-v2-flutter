import 'package:flutter/material.dart';

class NetworkCount extends StatelessWidget {
  @required
  final String title;
  @required
  final int amount;
  @required
  final String iconAsset;
  const NetworkCount({
    Key key,
    this.title,
    this.amount,
    this.iconAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 65) / 2,
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0XFFFFFFFF),
            child: Image.asset(
              iconAsset,
              height: 24,
              width: 24,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              amount != null
                  ? Text(
                      "$amount",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Text(
                      "0",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
