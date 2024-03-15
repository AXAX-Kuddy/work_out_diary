import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;

class BasePage extends StatelessWidget {
  final List<Widget> children;
  final AppBar? appBar;

  const BasePage({
    super.key,
    required this.children,
    this.appBar,
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
          padding: const EdgeInsets.all(15),
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
    );
  }
}
