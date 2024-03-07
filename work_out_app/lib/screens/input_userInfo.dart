import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/wide_button.dart';
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
  bool _isSelectd = false;
  final nameFormKey = GlobalKey<FormState>();

  bool nameFieldValid = false;
  bool sbdValid = false;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          verticalAxis: CrossAxisAlignment.center,
          inputContent: const [
            Text(
              "당신의 정보를 입력해주세요",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        WidgetsBox(
          width: 300,
          backgroundColor: palette.bgColor,
          verticalAxis: CrossAxisAlignment.center,
          inputContent: [
            Form(
                key: nameFormKey,
                child: CoustomTextField(
                  hintText: "이름을 입력해주세요",
                  textStyle: TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 18,
                  ),
                  isValid: nameFieldValid,
                  validator: (value) {
                    RegExp regex = RegExp(r'^[ㄱ-ㅎ가-힣a-zA-Z0-9]+$');
                    if (value!.isEmpty) {
                      setState(() {
                        nameFieldValid = false;
                      });
                      return "이름을 입력해주세요!";
                    } else if (value.length > 10) {
                      setState(() {
                        nameFieldValid = false;
                      });
                      return "이름은 10글자 이하로 해주세요!";
                    } else if (!regex.hasMatch(value)) {
                      return "특수문자를 제외해야해요!";
                    } else {
                      setState(() {
                        nameFieldValid = true;
                      });
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    userName = newValue;
                    print(userName);
                  },
                )),
            const SizedBox(
              width: 12,
            ),
            WideButton(
              onTapUpFunction: () {
                final formKeyState = nameFormKey.currentState!;
                if (formKeyState.validate()) {
                  formKeyState.save();
                }
              },
              inputContent: const [
                Text("확인"),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Text(
              "성별",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
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
                _isSelectd = true;
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
                border: Border.all(
                  color: _isSelectd
                      ? palette.cardColorYelGreen
                      : palette.bgFadeColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(14),
                color: palette.bgColor,
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
        const SizedBox(
          height: 30,
        ),
        WidgetsBox(
          backgroundColor: palette.bgColor,
          inputContent: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "PR",
                      style: TextStyle(
                        color: palette.cardColorWhite,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    const Text(
                      "스쿼트",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100,
                      height: 60,
                      child: CoustomTextField(
                        isValid: sbdValid,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class CoustomTextField extends StatefulWidget {
  String? userName;
  bool isValid = false;

  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  void Function(String?)? onSaved;
  final String? hintText;
  final TextStyle? textStyle;

  CoustomTextField({
    super.key,
    this.userName,
    this.hintText,
    this.validator,
    required this.isValid,
    this.onChanged,
    this.onSaved,
    this.textStyle,
  });

  @override
  State<CoustomTextField> createState() => _CoustomTextFieldState();
}

class _CoustomTextFieldState extends State<CoustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: _controller,
        onSaved: widget.onSaved,
        validator: widget.validator,
        cursorColor: palette.cardColorYelGreen,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: palette.cardColorWhite,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isValid
                  ? palette.cardColorYelGreen
                  : palette.cardColorYelGreen,
              width: 3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isValid
                  ? palette.cardColorYelGreen
                  : palette.bgFadeColor,
              width: 3,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: widget.textStyle,
        ),
      ),
    );
  }
}
