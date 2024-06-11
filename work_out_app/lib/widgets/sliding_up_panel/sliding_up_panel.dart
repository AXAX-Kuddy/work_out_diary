import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:work_out_app/util/palette.dart' as palette;

class CustomSlidingUpPanelWidget extends StatefulWidget {
  final List<PanelItemBuilder> children;

  const CustomSlidingUpPanelWidget({
    super.key,
    required this.children,
  });

  @override
  State<CustomSlidingUpPanelWidget> createState() =>
      _CustomSlidingUpPanelWidgetState();
}

class _CustomSlidingUpPanelWidgetState
    extends State<CustomSlidingUpPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
