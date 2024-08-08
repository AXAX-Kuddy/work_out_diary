// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/user_info_screen.dart/age_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen_widgets/input.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:work_out_app/widgets/text_field/text_field.dart';
import 'package:work_out_app/provider/store.dart' as provider;

class NameInput extends StatefulWidget {
  const NameInput({
    super.key,
  });

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  late provider.UserInfo userInfo;
  late Function({required UserInfoField userInfoField, required dynamic value})
      setUserInfo;

  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool nameValid = false;

  String? name;

  @override
  void initState() {
    super.initState();

    userInfo = context.read<provider.MainStoreProvider>().userInfo;
    setUserInfo = context.read<provider.MainStoreProvider>().setUserInfo;

    ///유저 이름 설정 여부
    if (userInfo[UserInfoField.userName] != DevelopName.devName.key) {
      controller.text = userInfo[UserInfoField.userName];
      setState(() {
        nameValid = true;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      mainAxisAlignment: MainAxisAlignment.center,
      children: InputField.mainInput(
        backButton: false,
        context: context,
        title: "반갑습니다! 당신의 이름을 알려주세요!",
        children: [
          CustomTextField(
            formKey: nameKey,
            isValid: nameValid,
            controller: controller,
            focusNode: focusNode,
            textInputType: TextInputType.name,
            width: 300,
            hintText: "이름을 입력해주세요",
            hintStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
            textStyle: const TextStyle(
              color: palette.cardColorWhite,
              fontSize: 15,
            ),
            validator: (value) {
              /// 정규식
              RegExp regex = RegExp(r'^[ㄱ-ㅎ가-힣a-zA-Z0-9]+$');

              /// 값이 비어있다면
              if (value == null || value.isEmpty) {
                setState(() {
                  nameValid = false;
                });
                return "이름을 입력해주세요!";
              }

              /// 개발용 이름 중복 방지
              if (value == DevelopName.devName.key) {
                setState(() {
                  nameValid = false;
                });
                return "사용 불가능한 이름입니다.";
              }

              /// 이름이 10글자를 초과했다면
              if (value.length > 10) {
                setState(() {
                  nameValid = false;
                });
                return "이름은 10글자 이하로 해주세요!";
              }

              /// 글자 이외에 다른 문자가 들어갈 경우
              if (!regex.hasMatch(value)) {
                setState(() {
                  nameValid = false;
                });
                return "특수문자나 띄어쓰기를 제외해야해요!";
              }

              /// 모든 예외를 통과했다면
              setState(() {
                name = value;
                nameValid = true;
              });

              return null;
            },
            onFocusout: () {
              CustomTextField.submit(nameKey);
            },
            onFieldSubmitted: (String? value) {
              CustomTextField.submit(nameKey);
            },
          ),
        ],
        onTapUp: () {
          /// 다음페이지로 넘어가기 전 검사
          CustomTextField.submit(nameKey);

          /// 모든 입력을 완료했을 때
          if (nameValid) {
            setUserInfo(
              userInfoField: UserInfoField.userName,
              value: name,
            );

            SlidePage.goto(
              context: context,
              page: const AgeInput(),
            );
          }
        },
      ),
    );
  }
}
