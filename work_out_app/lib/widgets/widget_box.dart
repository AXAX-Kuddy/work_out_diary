import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;

class WidgetsBox extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final List<Widget> inputContent;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const WidgetsBox({
    super.key,
    this.backgroundColor = Colors.white,
    this.height = 100,
    required this.inputContent,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            ...inputContent,
          ],
        ),
      ),
    );
  }
}
