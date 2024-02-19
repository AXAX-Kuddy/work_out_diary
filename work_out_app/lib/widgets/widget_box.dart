import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;

class WidgetsBox extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double? width;
  final List<Widget> inputContent;
  final MainAxisAlignment horizontalAxis;
  final CrossAxisAlignment verticalAxis;

  const WidgetsBox({
    super.key,
    this.backgroundColor = Colors.white,
    this.height = 100,
    this.width,
    required this.inputContent,
    this.horizontalAxis = MainAxisAlignment.spaceEvenly,
    this.verticalAxis = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: horizontalAxis,
          crossAxisAlignment: verticalAxis,
          children: [
            ...inputContent,
          ],
        ),
      ),
    );
  }
}
