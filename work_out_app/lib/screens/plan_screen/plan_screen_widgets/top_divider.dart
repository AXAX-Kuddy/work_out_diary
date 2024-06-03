import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class TopDivider extends StatelessWidget {
  const TopDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "세트",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette.cardColorWhite,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "무게",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "갯수",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "RPE",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "완료",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
      ],
    );
  }
}
