import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class CustomDropDownButton extends StatefulWidget {
  final String hint;
  final TextStyle? textStyle;
  final TextStyle? itemTextStyle;
  final List<String> itemList;
  dynamic inputValue;
  VoidCallback? selectChecker;
  final Function(String)? returnableChecker;
  final bool enabledValid;
  String? nowValue;

  ///setState는 기본값
  final void Function(String?)? onChanged;
  final double width;
  final double height;

  CustomDropDownButton({
    super.key,
    required this.itemList,
    this.inputValue,
    this.hint = "기본값",
    this.onChanged,
    this.width = 130,
    this.height = 60,
    this.selectChecker,
    this.returnableChecker,
    this.textStyle,
    this.itemTextStyle,
    this.enabledValid = true,
    this.nowValue,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? selectedValue;
  bool _isSelectd = false;

  @override
  void initState() {
    super.initState();

    if (widget.nowValue != null) {
      if (double.parse(widget.nowValue!) != 0) {
        selectedValue = widget.nowValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            widget.hint,
            style: widget.textStyle,
          ),
          items: widget.itemList
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: widget.itemTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            selectedValue = value;
            if (widget.selectChecker != null) {
              widget.selectChecker!();
            }
            if (widget.returnableChecker != null) {
              widget.returnableChecker!(value!);
            }
            if (widget.enabledValid) {
              setState(() {
                _isSelectd = true;
              });
            }
            setState(() {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 60,
            width: 130,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isSelectd
                    ? palette.cardColorYelGreen
                    : palette.bgFadeColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(14),
              color: palette.bgColor,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: LineIcon.angleRight(),
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
