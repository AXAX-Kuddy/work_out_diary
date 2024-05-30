import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class BasePage extends StatelessWidget {
  final List<Widget> children;
  final Widget slidingUpPanelWidget;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets padding;

  const BasePage({
    super.key,
    required this.children,
    this.slidingUpPanelWidget = const SizedBox.shrink(),
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.padding = const EdgeInsets.all(15),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          body: Container(
            decoration: BoxDecoration(
              color: palette.bgColor,
            ),
            // ignore: prefer_const_constructors
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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


