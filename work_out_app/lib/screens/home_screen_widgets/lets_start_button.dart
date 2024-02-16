import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/widget_box.dart';

class StartButton extends StatefulWidget {
  final Function changePage;

  const StartButton({
    super.key,
    required this.changePage,
  });

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  var btnColor = palette.cardColorWhite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (details) {
          setState(() {
            btnColor = Colors.grey;
          });
        },
        onTapUp: (details) {
          setState(() {
            btnColor = palette.cardColorWhite;
            widget.changePage(1);
          });
        },
        child: WidgetsBox(
          backgroundColor: btnColor,
          crossAxisAlignment: CrossAxisAlignment.center,
          height: 50,
          inputContent: const [
            SizedBox(
              width: 10,
            ),
            Text(
              "루틴 계획하러 가기",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            LineIcon(
              LineIcons.angleRight,
              size: 20,
            ),
          ],
        ));
  }
}
