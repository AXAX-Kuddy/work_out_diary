import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

abstract class BaseCancelAndEnterButton extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final double? spaceWidth;

  final VoidCallback? onCancelTap;
  final Widget cancelLabel;

  final VoidCallback? onEnterTap;
  final Widget enterLabel;

  const BaseCancelAndEnterButton({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.spaceWidth,
    required this.onCancelTap,
    this.cancelLabel = const Text(
      "취소",
      style: TextStyle(
        color: palette.colorRed,
      ),
    ),
    required this.onEnterTap,
    this.enterLabel = const Text(
      "확인",
      style: TextStyle(
        color: palette.cardColorWhite,
      ),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextButton(
          onPressed: onEnterTap,
          child: enterLabel,
        ),
        SizedBox(
          width: spaceWidth,
        ),
        TextButton(
          onPressed: onCancelTap,
          child: cancelLabel,
        ),
      ],
    );
  }
}

class CancelAndEnterButtonWithIcon extends BaseCancelAndEnterButton {
  final Widget cancelIcon;
  final Widget enterIcon;

  const CancelAndEnterButtonWithIcon({
    super.key,
    super.mainAxisAlignment,
    super.spaceWidth,
    required super.onCancelTap,
    required this.cancelIcon,
    required super.cancelLabel,
    required super.onEnterTap,
    required this.enterIcon,
    required super.enterLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextButton.icon(
          onPressed: onEnterTap,
          icon: enterIcon,
          label: enterLabel,
        ),
        SizedBox(
          width: spaceWidth,
        ),
        TextButton.icon(
          onPressed: onCancelTap,
          icon: cancelIcon,
          label: cancelLabel,
        ),
      ],
    );
  }
}

class CancelAndEnterButton extends BaseCancelAndEnterButton {
  const CancelAndEnterButton({
    super.key,
    mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    double? spaceWidth,
    required onCancelTap,
    cancelLabel = const Text(
      "취소",
      style: TextStyle(
        color: palette.colorRed,
      ),
    ),
    required onEnterTap,
    enterLabel = const Text(
      "확인",
      style: TextStyle(
        color: palette.cardColorWhite,
      ),
    ),
  }) : super(
          mainAxisAlignment: mainAxisAlignment,
          spaceWidth: spaceWidth,
          onCancelTap: onCancelTap,
          cancelLabel: cancelLabel,
          onEnterTap: onEnterTap,
          enterLabel: enterLabel,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextButton(
          onPressed: onEnterTap,
          child: enterLabel,
        ),
        SizedBox(
          width: spaceWidth,
        ),
        TextButton(
          onPressed: onCancelTap,
          child: cancelLabel,
        ),
      ],
    );
  }
}
