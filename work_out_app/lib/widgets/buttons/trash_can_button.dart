import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class TrashCan extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final double? size;
  final String? semanticLabel;
  final TextDirection? textDecoration;

  const TrashCan({
    super.key,
    this.onPressed,
    this.color = palette.colorRed,
    this.size,
    this.semanticLabel,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed?.call();
      },
      icon: LineIcon(
        LineIcons.trash,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDecoration,
      ),
    );
  }
}
