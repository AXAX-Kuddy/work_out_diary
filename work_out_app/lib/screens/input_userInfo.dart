import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  var userName;
  var userSBD = [];
  var dotsPoint;
  var isFemale;
  var itemList = [
    "남성",
    "여성",
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          verticalAxis: CrossAxisAlignment.center,
          inputContent: const [
            Text(
              "정보를 입력해주세요",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            items: itemList
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              selectedValue = value;
              setState(() {
                if (value == "남성") {
                  isFemale = false;
                } else if (value == "여성") {
                  isFemale = true;
                }
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 60,
              width: 130,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: palette.bgFadeColor,
              ),
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
      ],
    );
  }
}
