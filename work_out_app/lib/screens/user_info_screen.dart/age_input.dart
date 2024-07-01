import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/user_info_screen.dart/name_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/sbd_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen_widgets/input.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/drop_downs/drop_down.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:work_out_app/widgets/text_field/text_field.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;

class AgeInput extends StatefulWidget {
  const AgeInput({super.key});

  @override
  State<AgeInput> createState() => _AgeInputState();
}

class _AgeInputState extends State<AgeInput> {
  late provider.UserInfo userInfo;
  late Function({required UserInfoField userInfoField, required dynamic value})
      setUserInfo;

  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> ageKey = GlobalKey<FormState>();
  final FocusNode ageFocusNode = FocusNode();

  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> weightKey = GlobalKey<FormState>();
  final FocusNode weightFocusNode = FocusNode();

  ///현재 선택된 드롭다운 아이템 변수
  ///페이지를 불러올 때 값이 있다면
  String? nowDropDownValue;

  bool isFemale = false;
  int? userAge;
  double? weight;

  bool ageValid = false;
  bool genderValid = false;
  bool weightValid = false;

  @override
  void initState() {
    userInfo = context.read<provider.MainStoreProvider>().userInfo;
    setUserInfo = context.read<provider.MainStoreProvider>().setUserInfo;

    /// 사용자가 나이 및 성별을 기입했는지 여부
    if (userInfo[UserInfoField.age] != 999) {
      ageController.text = userInfo[UserInfoField.age].toString();
      setState(() {
        genderValid = true;
        ageValid = true;
      });

      /// 유저 성별 파악
      if (userInfo[UserInfoField.isFemale]) {
        setState(() {
          isFemale = true;
          nowDropDownValue = "여자";
        });
      } else {
        setState(() {
          isFemale = false;
          nowDropDownValue = "남자";
        });
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      mainAxisAlignment: MainAxisAlignment.center,
      children: InputField.mainInput(
        context: context,
        backTo: const NameInput(),
        title: "나이와 성별도 알고싶어요!",
        childrenWidth: 300,
        children: [
          Expanded(
            child: CustomTextField(
              formKey: ageKey,
              focusNode: ageFocusNode,
              controller: ageController,
              margin: const EdgeInsets.only(
                right: 10,
              ),
              hintText: "나이",
              textStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              textInputType: TextInputType.number,
              isValid: ageValid,
              validator: (value) {
                /// 값이 null이 아닐 때
                if (value != null) {
                  /// 값이 비어있다면
                  if (value.isEmpty) {
                    setState(() {
                      ageValid = false;
                    });
                    return "값을 입력해주세요!";
                  }

                  /// 값이 숫자가 아니라면
                  if (int.tryParse(value) == null) {
                    setState(() {
                      ageValid = false;
                    });
                    return "숫자만 입력해주세요!";
                  }

                  /// 값이 숫자일 때
                  if (int.tryParse(value) != null) {
                    // 비정상적인 값을 입력했을 경우
                    if (int.parse(value) > 118 || int.parse(value) <= 0) {
                      setState(() {
                        ageValid = false;
                      });
                      return "장난금지!";
                    }
                  }
                }

                /// 모든 예외를 통과했다면
                setState(() {
                  ageValid = true;
                  userAge = int.parse(value!);
                });
                return null;
              },
              onFocusout: () {
                CustomTextField.submit(ageKey);
              },
              onSaved: (String? newValue) {
                if (int.tryParse(newValue!) != null) {
                  setState(() {
                    userAge = int.parse(newValue);
                  });
                }
              },
              onFieldSubmitted: (value) {
                CustomTextField.submit(ageKey);
              },
            ),
          ),
          Expanded(
            child: CustomDropDownButton(
              hint: "성별",
              textStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              itemTextStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              width: null,
              height: 55,
              itemList: const [
                "남자",
                "여자",
              ],
              nowValue: nowDropDownValue,
              enabledValid: genderValid,
              onChanged: (value) {
                if (value == "남자") {
                  setState(() {
                    genderValid = true;
                    isFemale = false;
                  });
                } else {
                  setState(() {
                    genderValid = true;
                    isFemale = true;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: CustomTextField(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              isValid: weightValid,
              focusNode: weightFocusNode,
              formKey: weightKey,
            ),
          ),
        ],
        onTapUp: () {
          /// 다음페이지로 넘어가기 전 검사
          CustomTextField.submit(ageKey);

          ///모든 입력을 완료했을 때
          if (ageValid && genderValid) {
            setUserInfo(
              userInfoField: UserInfoField.age,
              value: userAge,
            );

            setUserInfo(
              userInfoField: UserInfoField.isFemale,
              value: isFemale,
            );

            SlidePage.goto(
              context: context,
              page: const SBDInput(),
            );
          }
        },
      ),
    );
  }
}
