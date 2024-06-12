import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class CustomDialog extends StatelessWidget {
  final List<Widget> children;

  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final Color backgroundColor;
  final double width;
  final double height;

  const CustomDialog({
    super.key,
    this.children = const [],
    this.padding = const EdgeInsets.all(10),
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.backgroundColor = palette.bgColor,
    this.width = 100,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
