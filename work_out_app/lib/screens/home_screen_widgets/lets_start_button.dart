import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/palette.dart' as palette;

class StartButton extends StatefulWidget {
  const StartButton({
    super.key,
  });

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  var btnColor = palette.cardColorWhite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          btnColor = Colors.grey;
          print("색 바뀜 ㅋㅋ");
        });
      },
      onTapUp: (details) {
        setState(() {
          btnColor = palette.cardColorWhite;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "오늘의 운동 시작하기",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                LineIcon(
                  LineIcons.angleRight,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
