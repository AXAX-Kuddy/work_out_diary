// ignore_for_file: must_be_immutable

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
  final EdgeInsets? margin;
  final TextInputType? textInputType;
  final GlobalKey<FormState> formKey;
  final TextEditingController? controller;
  final FocusNode focusNode;

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
   required this.focusNode,
    this.onFocusout,
    this.margin,
    required this.formKey,
  });


    /// 텍스트 필드의 Form의 유휴성을 검사하고 통과한다면 저장합니다.
    /// 저장하고나면 validator가 null이 아니라면 실행됩니다.
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
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        return;
      } else {
        widget.onFocusout?.call();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: Form(
        key: widget.formKey,
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
      ),
    );
  }
}
