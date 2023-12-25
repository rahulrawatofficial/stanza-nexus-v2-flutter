import 'package:flutter/material.dart';
import 'package:nexus_app/model/partner_list_model.dart';
import 'package:nexus_app/ui/Network/Lead/ToolTipLead/lead_info_tip.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TargetWidget extends StatefulWidget {
  final String userId;
  const TargetWidget({Key key, @required this.userId}) : super(key: key);

  @override
  _TargetWidgetState createState() => new _TargetWidgetState();
}

class _TargetWidgetState extends State<TargetWidget> {
  SuperTooltip tooltip;

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (tooltip.isOpen) {
      tooltip.close();
      return false;
    }
    return true;
  }

  void onTap() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.up,
      maxWidth: 300.0,
      minWidth: 300.0,
      maxHeight: 330,
      left: 50,
      arrowTipDistance: 12,
      arrowLength: 8,
      borderWidth: 0,
      borderRadius: 8,
      borderColor: Color(0XFFEDFFF5),
      backgroundColor: Color(0XFFEDFFF5),
      hasShadow: false,
      content: new Material(
        color: Color(0XFFEDFFF5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LeadInfoTip(
            userId: widget.userId,
          ),
        ),
      ),
    );

    tooltip.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _willPopCallback,
      child: new GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.info_outline,
          size: 24.0,
        ),
      ),
    );
  }
}
