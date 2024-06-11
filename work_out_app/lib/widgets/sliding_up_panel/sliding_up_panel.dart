import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

import 'package:work_out_app/util/palette.dart' as palette;

class CustomSlidingUpPanelWidget extends StatefulWidget {
  final List<PanelItemBuilder> children;
  final SlidingUpPanelController controller;
  final bool onlyAnchor;
  final void Function(SlidingUpPanelStatus status)? onStatusChanged;

  const CustomSlidingUpPanelWidget({
    super.key,
    required this.children,
    required this.controller,
    this.onStatusChanged,
    this.onlyAnchor = true,
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
      controlHeight: 50,
      panelController: widget.controller,
      enableOnTap: false,
      panelStatus: SlidingUpPanelStatus.hidden,
      onStatusChanged: (SlidingUpPanelStatus status) {
        if (widget.onlyAnchor) {
          if (status == SlidingUpPanelStatus.expanded) {
            widget.controller.anchor();
          }
          if (status == SlidingUpPanelStatus.collapsed) {
            widget.controller.hide();
          }
        } else {
          if (status == SlidingUpPanelStatus.collapsed) {
            widget.controller.hide();
          }
        }

        widget.onStatusChanged?.call(status);
      },
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
                    children: widget.children.map((itemBuilder) {
                      return itemBuilder.builder(context, constraints);
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PanelItemBuilder {
  final Widget Function(BuildContext, BoxConstraints) builder;

  PanelItemBuilder({required this.builder});

  Widget build(BuildContext context, BoxConstraints constraints) {
    return builder(context, constraints);
  }
}
