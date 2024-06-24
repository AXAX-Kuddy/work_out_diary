import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/util/palette.dart' as palette;


class InputField {
  static List<Widget> mainInput({
    required String title,
    required List<Widget> children,
    required VoidCallback onTapUp,
    bool? goHomeScreenButton,
  }) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: palette.cardColorWhite,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: WideButton(
                unTapColor: palette.bgFadeColor,
                tapColor: palette.bgColor,
                tapBorderColor: palette.cardColorYelGreen,
                onTapUpFunction: onTapUp,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "다음으로",
                          style: TextStyle(
                            color: palette.cardColorWhite,
                          ),
                        ),
                        Spacer(),
                        LineIcon(
                          color: palette.cardColorWhite,
                          size: 20,
                          LineIcons.angleRight,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
