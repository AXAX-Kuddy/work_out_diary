// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:work_out_app/screens/user_info_screen.dart/age_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen_widgets/input.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/text_field/text_field.dart';

class NameInput extends StatefulWidget {
  const NameInput({
    super.key,
  });

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool nameValid = false;

  String? _name;

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
        title: "환영합니다! 당신의 이름을 알려주세요!",
        goHomeScreenButton: true,
        children: [
          Form(
              key: nameKey,
              child: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                onFocusout: () {},
                textInputType: TextInputType.name,
                width: 300,
                hintText: "이름을 입력해주세요",
                textStyle: const TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 15,
                ),
                isValid: nameValid,
                validator: (value) {
                  RegExp regex = RegExp(r'^[ㄱ-ㅎ가-힣a-zA-Z0-9]+$');
                  if (value!.isEmpty) {
                    setState(() {
                      nameValid = false;
                    });
                    return "이름을 입력해주세요!";
                  } else if (value.length > 10) {
                    setState(() {
                      nameValid = false;
                    });
                    return "이름은 10글자 이하로 해주세요!";
                  } else if (!regex.hasMatch(value)) {
                    setState(() {});
                    return "특수문자나 띄어쓰기를 제외해야해요!";
                  } else {
                    setState(() {
                      nameValid = true;
                    });
                    return null;
                  }
                },
                onSaved: (String? newValue) {
                  setState(() {
                    _name = newValue;
                  });
                },
                onFieldSubmitted: (String? value) {
                  CustomTextField.submit(nameKey);
                },
              )),
        ],
        onTapUp: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const AgeInput();
              },
            ),
          );
        },
      ),
    );
  }
}
