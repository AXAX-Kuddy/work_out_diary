import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;

class CoustomTextField extends StatefulWidget {
  String? userName;
  bool isValid = false;

  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  void Function(String)? onFieldSubmitted;
  void Function(String?)? onSaved;
  final String? hintText;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final TextInputType? textInputType;

  CoustomTextField({
    super.key,
    this.userName,
    this.height,
    this.width,
    this.hintText,
    this.validator,
    required this.isValid,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.textStyle,
    this.textInputType,
  });

  @override
  State<CoustomTextField> createState() => _CoustomTextFieldState();
}

class _CoustomTextFieldState extends State<CoustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: _controller,
        keyboardType: widget.textInputType,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        validator: widget.validator,
        cursorColor: palette.cardColorYelGreen,
        textAlign: TextAlign.center,
        style: widget.textStyle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isValid
                  ? palette.cardColorYelGreen
                  : palette.cardColorYelGreen,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isValid
                  ? palette.cardColorYelGreen
                  : palette.bgFadeColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: widget.textStyle,
        ),
      ),
    );
  }
}
