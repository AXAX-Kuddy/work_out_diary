import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class IntensitySelector extends StatefulWidget {
  final String hint;
  final TextStyle? textStyle;
  final TextStyle? itemTextStyle;
  dynamic inputValue;
  VoidCallback? selectChecker;
  final Function(String)? returnableChecker;

  final void Function(int?)? onChanged;
  final double width;
  final double height;

  IntensitySelector({
    super.key,
    this.inputValue,
    this.hint = "기본값",
    this.onChanged,
    this.width = 130,
    this.height = 60,
    this.selectChecker,
    this.returnableChecker,
    this.textStyle,
    this.itemTextStyle,
  });

  @override
  State<IntensitySelector> createState() => _IntensitySelectorState();
}

class _IntensitySelectorState extends State<IntensitySelector> {
  dynamic selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<int>(
          isExpanded: true,
          hint: Text(
            widget.hint,
            style: widget.textStyle,
          ),
          items: [
            DropdownMenuItem<int>(
              value: 0,
              child: Text(
                "직접 입력",
                style: widget.itemTextStyle,
              ),
            ),
            DropdownMenuItem<int>(
              value: 1,
              child: Text(
                "1rm%",
                style: widget.itemTextStyle,
              ),
            ),
            DropdownMenuItem<int>(
              value: 2,
              child: Text(
                "rpe",
                style: widget.itemTextStyle,
              ),
            ),
          ],
          value: selectedValue,
          onChanged: (value) {
            selectedValue = value;
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          buttonStyleData: const ButtonStyleData(
            height: 60,
            width: 130,
            padding: EdgeInsets.only(left: 14, right: 14),
            elevation: 2,
          ),
          iconStyleData: IconStyleData(
            icon: const LineIcon.angleRight(),
            iconSize: 14,
            iconEnabledColor: palette.cardColorWhite,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: palette.bgColor,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
