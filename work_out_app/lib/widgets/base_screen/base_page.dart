import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class BasePage extends StatelessWidget {
  final List<Widget> children;
  final Widget slidingUpPanelWidget;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets padding;
  final Color backgroundColor;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const BasePage({
    super.key,
    required this.children,
    this.slidingUpPanelWidget = const SizedBox.shrink(),
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.padding = const EdgeInsets.all(15),
    this.backgroundColor = palette.bgColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          body: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            // ignore: prefer_const_constructors
            child: Padding(
              padding: padding,
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ...children
                ],
              ),
            ),
          ),
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        ),
        slidingUpPanelWidget,
      ],
    );
  }
}
