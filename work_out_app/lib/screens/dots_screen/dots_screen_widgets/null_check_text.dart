import 'package:flutter/material.dart';

class NullCheckText extends StatelessWidget {
  final String data;
  final String nullMessege;
  final dynamic nullCheck;

  final TextStyle? textStyle;

  const NullCheckText({
    super.key,
    required this.data,
    required this.nullCheck,
    this.textStyle,
    this.nullMessege = "데이터가 입력되지 않았습니다.",
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      nullCheck == null ? nullMessege : data,
      style: textStyle,
    );
  }
}
