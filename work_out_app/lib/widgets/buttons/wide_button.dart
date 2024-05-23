import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';

class WideButton extends StatefulWidget {
  final Color unTapColor;
  final Color tapColor;
  final Color tapBorderColor;
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
    this.tapBorderColor = const Color.fromRGBO(0, 0, 0, 0),
  });

  @override
  State<WideButton> createState() => _WideButtonState();
}

class _WideButtonState extends State<WideButton> {
  late Color btnColor;
  late bool buttonTest;
  Color borderColor = const Color.fromRGBO(0, 0, 0, 0);

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
            borderColor = widget.tapBorderColor;
          });
        },
        onTapUp: (details) {
          setState(() {
            btnColor = widget.unTapColor;
            borderColor = const Color.fromRGBO(0, 0, 0, 0);
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
          border: Border.all(
            color: borderColor,
          ),
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
