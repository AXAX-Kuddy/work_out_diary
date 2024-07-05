import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class WideButton extends StatefulWidget {
  final Color unTapColor;
  final Color tapColor;
  final Color tapBorderColor;
  final List<BoxShadow>? boxShadow;
  final Widget child;
  final bool buttonTest;
  final void Function()? onTapDownFunction;
  final void Function()? onTapUpFunction;

  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;

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
    this.margin,
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

    super.initState();
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
        margin: widget.margin,
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

class WideButtonBlack extends WideButton {
  const WideButtonBlack({
    super.key,
    super.width,
    super.height,
    super.margin,
    super.child,
    super.onTapDownFunction,
    super.onTapUpFunction,
    super.buttonTest = false,
    super.boxShadow,
    super.tapColor = palette.bgColor,
    super.unTapColor = palette.bgFadeColor,
    super.tapBorderColor = palette.cardColorYelGreen,
  });
}
