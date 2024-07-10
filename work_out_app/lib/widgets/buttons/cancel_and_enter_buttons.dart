import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

abstract class BaseCancelAndEnterButton extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final bool buttonSwap;
  final double? spaceWidth;

  final VoidCallback? onCancelTap;
  final Widget cancelLabel;

  final VoidCallback? onEnterTap;
  final Widget enterLabel;

  const BaseCancelAndEnterButton({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.buttonSwap = false,
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
    if (buttonSwap) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          TextButton(
            onPressed: onCancelTap,
            child: cancelLabel,
          ),
          SizedBox(
            width: spaceWidth,
          ),
          TextButton(
            onPressed: onEnterTap,
            child: enterLabel,
          ),
        ],
      );
    } else {
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
}

class CancelAndEnterButtonWithIcon extends BaseCancelAndEnterButton {
  final Widget cancelIcon;
  final Widget enterIcon;

  const CancelAndEnterButtonWithIcon({
    super.key,
    super.mainAxisAlignment,
    super.buttonSwap,
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
    if (super.buttonSwap) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          TextButton.icon(
            onPressed: onCancelTap,
            icon: cancelIcon,
            label: cancelLabel,
          ),
          SizedBox(
            width: spaceWidth,
          ),
          TextButton.icon(
            onPressed: onEnterTap,
            icon: enterIcon,
            label: enterLabel,
          ),
        ],
      );
    } else {
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
}

class CancelAndEnterButton extends BaseCancelAndEnterButton {
  const CancelAndEnterButton({
    super.key,
    super.mainAxisAlignment,
    super.buttonSwap,
    super.spaceWidth,
    super.onCancelTap,
    super.cancelLabel,
    super.onEnterTap,
    super.enterLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (super.buttonSwap) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          TextButton(
            onPressed: onCancelTap,
            child: cancelLabel,
          ),
          SizedBox(
            width: spaceWidth,
          ),
          TextButton(
            onPressed: onEnterTap,
            child: enterLabel,
          ),
        ],
      );
    } else {
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
}
