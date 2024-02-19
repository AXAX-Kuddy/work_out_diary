import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/store.dart';
import 'package:work_out_app/widgets/widget_box.dart';

class WideButton extends StatefulWidget {
  final Color unTapColor;
  final Color tapColor;
  final List<Widget> inputContent;
  final bool buttonTest;
  final Function? onTapUpFunction;

  final MainAxisAlignment horizontalAxis;
  final CrossAxisAlignment verticalAxis;

  final double height;
  final double? width;

  const WideButton({
    super.key,
    this.unTapColor = const Color.fromARGB(226, 255, 255, 255),
    this.tapColor = const Color.fromARGB(183, 255, 255, 255),
    this.inputContent = const [
      Text("컨텐츠를 입력하세요"),
    ],
    this.onTapUpFunction,
    this.buttonTest = false,
    this.horizontalAxis = MainAxisAlignment.center,
    this.verticalAxis = CrossAxisAlignment.center,
    this.height = 50,
    this.width,
  });

  @override
  State<WideButton> createState() => _WideButtonState();
}

class _WideButtonState extends State<WideButton> {
  late Color btnColor;
  late bool buttonTest;

  @override
  void initState() {
    btnColor = widget.unTapColor;
    buttonTest = widget.buttonTest;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (details) {
          setState(() {
            btnColor = widget.tapColor;
          });
        },
        onTapUp: (details) {
          setState(() {
            btnColor = widget.unTapColor;
          });
          if (buttonTest) {
            print("버튼테스트");
          }
          widget.onTapUpFunction?.call();
        },
        onTapCancel: () {
          setState(() {
            btnColor = widget.unTapColor;
          });
        },
        child: WidgetsBox(
          backgroundColor: btnColor,
          horizontalAxis: widget.horizontalAxis,
          verticalAxis: widget.verticalAxis,
          height: widget.height,
          width: widget.width,
          inputContent: [
            ...widget.inputContent,
          ],
        ));
  }
}
