import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;

class BasePage extends StatefulWidget {
  final List<Widget> children;
  final Widget slidingUpPanelWidget;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets padding;
  final Color backgroundColor;

  const BasePage({
    super.key,
    required this.children,
    this.slidingUpPanelWidget = const SizedBox.shrink(),
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.padding = const EdgeInsets.all(15),
    this.backgroundColor = palette.bgColor,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: widget.appBar,
          body: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
            // ignore: prefer_const_constructors
            child: Padding(
              padding: widget.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ...widget.children
                ],
              ),
            ),
          ),
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
        ),
        widget.slidingUpPanelWidget,
      ],
    );
  }
}
