import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/resources/variables.dart';
import 'package:nexus_app/ui/Widgets/widget_methods.dart';

class DateRangeFilter extends StatefulWidget {
  final DateTime currentFromDate;
  final Function(DateTime) fromDateChange;
  final DateTime currentToDate;
  final Function(DateTime) toDateChange;
  const DateRangeFilter({
    Key key,
    @required this.currentFromDate,
    @required this.fromDateChange,
    @required this.currentToDate,
    @required this.toDateChange,
  }) : super(key: key);

  @override
  _DateRangeFilterState createState() => _DateRangeFilterState();
}

class _DateRangeFilterState extends State<DateRangeFilter> {
  DateTime fromDate = DateTime.fromMillisecondsSinceEpoch(userData.createdAt);
  DateTime toDate = DateTime.now();

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  final DateFormat formatter = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    if (widget.currentFromDate != null) {
      fromDate = widget.currentFromDate;
      fromDateController.text = formatter.format(fromDate);
    }
    if (widget.currentToDate != null) {
      toDate = widget.currentToDate;
      toDateController.text = formatter.format(toDate);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                selectDateFromPicker(context, null, fromDate).then((value) {
                  setState(() {
                    fromDate = value;
                    fromDateController.text = formatter.format(value);
                  });
                  widget.fromDateChange(value);
                });
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: fromDateController,
                  decoration: InputDecoration(
                    hintText: "From Date",
                    suffix: Image.asset(
                      "assets/date.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                if (fromDateController.text.length > 0) {
                  selectDateFromPicker(context, fromDate, toDate).then((value) {
                    setState(() {
                      toDate = value;
                      toDateController.text = formatter.format(value);
                    });
                    widget.toDateChange(value);
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: toDateController,
                  decoration: InputDecoration(
                    hintText: "To Date",
                    suffix: Image.asset(
                      "assets/date.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
