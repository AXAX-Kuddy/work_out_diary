import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;

class BasePage extends StatelessWidget {
  final List<Widget> children;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets padding;

  const BasePage({
    super.key,
    required this.children,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.padding = const EdgeInsets.all(15),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
