import 'package:flutter/material.dart';

class UserAvatar extends StatefulWidget {
  final String assetName;
  final double radius;
  final String name;
  final bool enabled;
  const UserAvatar({
    Key key,
    @required this.assetName,
    @required this.radius,
    @required this.name,
    @required this.enabled,
  }) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    if (widget.assetName == null || widget.assetName == "null") {
      String initialsF = widget.name.substring(0, 1);
      String initialsS = widget.name.split(" ").last.substring(0, 1);
      String initials = initialsF + initialsS;
      return Stack(
        children: [
          CircleAvatar(
            radius: widget.radius,
            backgroundColor: Color(0XFF7D6476),
            child: Text(
              "${initials.toUpperCase()}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          widget.enabled || widget.enabled == null
              ? Offstage()
              : CircleAvatar(
                  radius: widget.radius,
                  backgroundColor: Colors.black.withOpacity(0.4),
                ),
        ],
      );
    } else {
      return Stack(
        children: [
          CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(widget.assetName),
          ),
          widget.enabled || widget.enabled == null
              ? Offstage()
              : CircleAvatar(
                  radius: widget.radius,
                  backgroundColor: Colors.black.withOpacity(0.4),
                ),
        ],
      );
    }
  }
}
