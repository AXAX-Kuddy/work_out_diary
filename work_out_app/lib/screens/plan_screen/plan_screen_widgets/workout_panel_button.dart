import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class InnerPanelButton extends StatelessWidget {
  final BoxConstraints constraints;

  final String contentText;
  final TextStyle contentTextStyle;
  final IconData icon;
  final Color iconColor;
  final bool showAngle;

  final void Function()? onTap;

  const InnerPanelButton({
    super.key,
    required this.constraints,
    required this.contentText,
    this.contentTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    required this.icon,
    required this.iconColor,
    this.showAngle = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: constraints.maxWidth * 0.88,
        height: 45,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(
          color: palette.cardColorGray,
        ))),
        child: Row(
          children: [
            LineIcon(
              icon,
              color: iconColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(contentText, style: contentTextStyle),
            const Spacer(),
            showAngle
                ? LineIcon(
                    LineIcons.angleRight,
                    color: palette.cardColorWhite,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
