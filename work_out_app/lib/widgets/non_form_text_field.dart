import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;

class CustomTextField2 extends StatefulWidget {
  final double? width;
  final double? height;
  final String? hintText;
  final TextInputType? textInputType;
  final TextStyle? textStyle;
  final TextEditingController? controller;

  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  bool valid;

  CustomTextField2({
    super.key,
    required this.valid,
    this.width,
    this.height,
    this.textInputType,
    this.textStyle,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        cursorColor: palette.cardColorYelGreen,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        style: widget.textStyle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.valid
                  ? palette.cardColorYelGreen
                  : palette.cardColorYelGreen,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.valid
                  ? palette.cardColorYelGreen
                  : palette.bgFadeColor,
              width: 1,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: widget.textStyle,
        ),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
