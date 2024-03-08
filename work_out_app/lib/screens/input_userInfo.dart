import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/wide_button.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:work_out_app/widgets/text_field.dart';
import 'package:work_out_app/widgets/drop_down.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  var userName;
  var age;
  var userSBD = {};
  var dotsPoint;
  var isFemale;
  var itemList = [
    "남성",
    "여성",
  ];

  final nameFormKey = GlobalKey<FormState>();
  final sbdFormKey = GlobalKey<FormState>();

  bool nameFieldValid = false;
  bool ageFieldValid = false;
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
          backgroundColor: palette.bgColor,
          inputContent: [
            Form(
                key: nameFormKey,
                child: CoustomTextField(
                  width: 300,
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
                  },
                  onFieldSubmitted: (String? value) {
                    final formKeyState = nameFormKey.currentState!;
                    if (formKeyState.validate()) {
                      formKeyState.save();
                    }
                  },
                )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropDownButton(
              hint: "성별",
              itemList: itemList,
              onChanged: (value) {
                if (value == "남성") {
                  isFemale = false;
                  // print(isFemale);
                  // print(value);
                } else if (value == "여성") {
                  isFemale = true;
                  // print(isFemale);
                  // print(value);
                }
              },
            ),
            const SizedBox(
              width: 40,
            ),
            CustomDropDownButton(
              hint: "나이",
              itemList: List.generate(100, (index) => "${index + 1}"),
              onChanged: (value) {
                age = value;
                // print(value);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        WidgetsBox(
          backgroundColor: palette.bgColor,
          inputContent: [
            Form(
              key: sbdFormKey,
              child: Column(
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
                    height: 20,
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
                      CoustomTextField(
                        width: 120,
                        height: 100,
                        isValid: sbdValid,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              sbdValid = false;
                            });
                            return "값을 입력해주세요!";
                          } else {
                            setState(() {
                              sbdValid = true;
                            });
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          userSBD["스쿼트"] = newValue!;
                        },
                        onFieldSubmitted: (String? value) {
                          final formKeyState = sbdFormKey.currentState!;
                          if (formKeyState.validate()) {
                            formKeyState.save();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
