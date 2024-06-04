import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';

class WideButton extends StatefulWidget {
  final Color unTapColor;
  final Color tapColor;
  final Color tapBorderColor;
  final Widget child;
  final bool buttonTest;
  final Function? onTapUpFunction;


  final double height;
  final double? width;

  const WideButton({
    super.key,
    this.unTapColor = const Color.fromARGB(226, 255, 255, 255),
    this.tapColor = const Color.fromARGB(183, 255, 255, 255),
    this.child = const Text("컨텐츠를 입력하세요"),
    this.onTapUpFunction,
    this.buttonTest = false,
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
        height: widget.height,
        width: widget.width,
        child: widget.child,
      ),
    );
  }
}
