import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';


class WideButton extends StatefulWidget {
  final Color unTapColor;
  final Color tapColor;
  final Color tapBorderColor;
  final List<BoxShadow>? boxShadow;
  final Widget child;
  final bool buttonTest;
  final void Function()? onTapDownFunction;
  final void Function()? onTapUpFunction;

  final double height;
  final double? width;

  const WideButton({
    super.key,
    this.unTapColor = const Color.fromARGB(226, 255, 255, 255),
    this.tapColor = const Color.fromARGB(183, 255, 255, 255),
    this.boxShadow,
    this.child = const Text("컨텐츠를 입력하세요"),
    this.onTapDownFunction,
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
  List<BoxShadow>? currentBoxShadow;
  Color borderColor = const Color.fromRGBO(0, 0, 0, 0);

  @override
  void initState() {
    btnColor = widget.unTapColor;
    buttonTest = widget.buttonTest;
    currentBoxShadow = widget.boxShadow;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          btnColor = widget.tapColor;
          borderColor = widget.tapBorderColor;
          currentBoxShadow = null;
          widget.onTapDownFunction?.call();
        });
      },
      onTapUp: (details) {
        setState(() {
          btnColor = widget.unTapColor;
          borderColor = const Color.fromRGBO(0, 0, 0, 0);
          currentBoxShadow = widget.boxShadow;
          widget.onTapUpFunction?.call();
        });
        if (buttonTest) {
          print("버튼테스트");
        }
      },
      onTapCancel: () {
        setState(() {
          btnColor = widget.unTapColor;
          borderColor = const Color.fromRGBO(0, 0, 0, 0);
        });
      },
      child: WidgetsBox(
        backgroundColor: btnColor,
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: currentBoxShadow,
        height: widget.height,
        width: widget.width,
        child: widget.child,
      ),
    );
  }
}
