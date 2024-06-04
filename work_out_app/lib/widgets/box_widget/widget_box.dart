import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetsBox extends StatelessWidget {
  final Color backgroundColor;
  final double? height;
  final double? width;
  final Widget child;
  final Border? border;
  final EdgeInsetsGeometry? margin;

  const WidgetsBox({
    super.key,
    this.backgroundColor = Colors.white,
    this.height,
    this.width,
    required this.child,
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
        child: child,
      ),
    );
  }
}
