import 'package:flutter/material.dart';

class SelectGenderWidget extends StatefulWidget {
  final String currentGender;
  final Function(String) genderChange;
  const SelectGenderWidget({
    Key key,
    this.currentGender,
    this.genderChange,
  }) : super(key: key);

  @override
  _SelectGenderWidgetState createState() => _SelectGenderWidgetState();
}

class _SelectGenderWidgetState extends State<SelectGenderWidget> {
  Color enabledColor = Color(0XFF232728);
  Color disabledColor = Color(0XFFE6E9EA);

  String gender;

  @override
  void initState() {
    gender = widget.currentGender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GENDER",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    gender = "MALE";
                    widget.genderChange("MALE");
                  });
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: gender == "MALE" ? enabledColor : disabledColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/male.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "MALE",
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                gender == "MALE" ? enabledColor : disabledColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 17,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    gender = "FEMALE";
                    widget.genderChange("FEMALE");
                  });
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: gender == "FEMALE" ? enabledColor : disabledColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/female.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "FEMALE",
                          style: TextStyle(
                            fontSize: 16,
                            color: gender == "FEMALE"
                                ? enabledColor
                                : disabledColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
