import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class CustomTextField extends StatefulWidget {
  bool isValid = false;

  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final VoidCallback? onFocusout;
  final String? hintText;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  CustomTextField({
    super.key,
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
    this.controller,
    this.focusNode,
    this.onFocusout,
  });

  static void submit(GlobalKey<FormState> key) {
    final formKeyState = key.currentState!;
    if (formKeyState.validate()) {
      formKeyState.save();
    }
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    widget.focusNode?.addListener(() {
      if (widget.focusNode!.hasFocus) {
        return;
      } else {
        widget.onFocusout?.call();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        validator: widget.validator,
        cursorColor: palette.cardColorYelGreen,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        style: widget.textStyle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isValid
                  ? palette.cardColorYelGreen
                  : palette.cardColorYelGreen,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isValid
                  ? palette.cardColorYelGreen
                  : palette.bgFadeColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: widget.textStyle,
        ),
      ),
    );
  }
}
