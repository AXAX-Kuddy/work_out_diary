// ignore_for_file: unnecessary_overrides

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;

class CustomSlidingUpPanelWidget extends StatefulWidget {
  final SlidingUpPanelController panelController;
  final double controlHeight;
  final SlidingUpPanelStatus panelStatus;
  dynamic panelCallingInstance;
  int? panelCallingInstanceIndex;
  final String? title;
  final List<Widget Function(BoxConstraints)> children;

  final void Function(SlidingUpPanelStatus)? onStatusChanged;

  CustomSlidingUpPanelWidget({
    super.key,
    required this.panelController,
    required this.panelCallingInstance,
    this.panelCallingInstanceIndex,
    this.title,
    required this.children,
    this.controlHeight = 50,
    this.panelStatus = SlidingUpPanelStatus.hidden,
    this.onStatusChanged,
  });

  @override
  State<CustomSlidingUpPanelWidget> createState() =>
      _CustomSlidingUpPanelWidgetState();
}

class _CustomSlidingUpPanelWidgetState
    extends State<CustomSlidingUpPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanelWidget(
      controlHeight: widget.controlHeight,
      enableOnTap: false,
      panelController: widget.panelController,
      panelStatus: widget.panelStatus,
      onStatusChanged: widget.onStatusChanged,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: const ShapeDecoration(
              color: palette.bgFadeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: constraints.maxWidth * 0.3,
                  height: 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: palette.cardColorYelGreen,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: widget.children.map((childBuilder) {
                        return childBuilder(constraints);
                      }).toList(),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
