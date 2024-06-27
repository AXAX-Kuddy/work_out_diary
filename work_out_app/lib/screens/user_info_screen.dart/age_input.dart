import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:work_out_app/screens/user_info_screen.dart/name_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/sbd_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen_widgets/input.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/drop_downs/drop_down.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:work_out_app/widgets/text_field/text_field.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class AgeInput extends StatefulWidget {
  const AgeInput({super.key});

  @override
  State<AgeInput> createState() => _AgeInputState();
}

class _AgeInputState extends State<AgeInput> {
  final GlobalKey<FormState> ageKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  bool isFemale = false;
  int? userAge;

  bool ageValid = false;
  bool genderValid = false;

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
              focusNode: focusNode,
              margin: const EdgeInsets.only(
                right: 10,
              ),
              hintText: "나이",
              textStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              textInputType: TextInputType.number,
              isValid: ageValid,
              validator: (String? value) {
                ///값이 null이 아닐때
                if (value != null) {
                  ///값이 비어있다면
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

                    ///값이 숫자라면
                  } else if (int.tryParse(value) != null) {
                    ///비정상적인 값을 입력했을 경우
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
              margin: const EdgeInsets.only(
                left: 10,
              ),
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
        ],
        onTapUp: () {
          /// 다음페이지로 넘어가기 전 검사
          CustomTextField.submit(ageKey);

          ///모든 입력을 완료했을 때
          if (ageValid && genderValid) {
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
