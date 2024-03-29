import 'package:flutter/material.dart';

class WidgetsBox extends StatelessWidget {
  final Color backgroundColor;
  final double? height;
  final double? width;
  final List<Widget> inputContent;
  final MainAxisAlignment horizontalAxis;
  final CrossAxisAlignment verticalAxis;
  final Border? border;
  final EdgeInsetsGeometry? margin;

  const WidgetsBox({
    super.key,
    this.backgroundColor = Colors.white,
    this.height,
    this.width,
    required this.inputContent,
    this.horizontalAxis = MainAxisAlignment.spaceEvenly,
    this.verticalAxis = CrossAxisAlignment.start,
    this.border,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
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
