import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class CustomDropDownButton extends StatefulWidget {
  final String hint;
  final TextStyle? textStyle;
  final TextStyle? itemTextStyle;
  final List<String> itemList;
  final dynamic inputValue;

  /// 값 선택 유무
  final VoidCallback? selectChecker;

  /// 선택한 값 반환
  final Function(String)? returnableChecker;
  final bool enabledValid;

  /// 아이템이 숫자의 나열일 경우, 선택된 아이템을 해당 변수로 설정함
  ///
  /// 예 :
  /// ```
  /// if (widget.nowNum != null) {
  ///   if (widget.nowNum! != 0) {
  ///     selectedValue = widget.nowNum.toString();
  ///   }
  /// }
  /// ```
  final num? nowNum;

  ///아이템이 String의 나열일 경우, 선택된 아이템을 해당 변수로 설정함
  ///
  ///예 :
  ///```
  ///if (widget.nowNum != null) {
  ///   if (widget.nowNum! != 0) {
  ///     selectedValue = widget.nowNum.toString();
  ///   }
  /// }
  /// ```
  final String? nowValue;

  ///setState는 기본값
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final EdgeInsets? margin;

  const CustomDropDownButton({
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
    this.nowNum,
    this.nowValue,
    this.margin,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? selectedValue;
  bool _isSelectd = false;

  @override
  void didChangeDependencies() {
    if (widget.nowValue != null) {
      if (widget.nowValue!.isNotEmpty) {
        _isSelectd = true;
        selectedValue = widget.nowValue;
      }
    }

    if (widget.nowNum != null) {
      if (widget.nowNum! != 0) {
        _isSelectd = true;
        selectedValue = widget.nowNum.toString();
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
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
            _isSelectd = true;

            /// 값을 선택했는지 유무 체크
            if (widget.selectChecker != null) {
              widget.selectChecker!();
            }

            /// 선택한 값을 반환함
            if (widget.returnableChecker != null) {
              widget.returnableChecker!(value!);
            }

            /// 위젯 리빌드 시, valid를 true로 설정해야한다면
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
