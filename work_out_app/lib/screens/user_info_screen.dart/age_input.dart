import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen_widgets/input.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/drop_downs/drop_down.dart';
import 'package:work_out_app/widgets/text_field/text_field.dart';

class AgeInput extends StatelessWidget {
  const AgeInput({super.key});

  @override
  Widget build(BuildContext context) {
    bool ageValid = false;

    return BasePage(
      mainAxisAlignment: MainAxisAlignment.center,
      children: InputField.mainInput(
        context: context,
        title: "나이와 성별도 알고싶어요!",
        childrenWidth: 300,
        children: [
          Expanded(
            child: CustomTextField(
              margin: const EdgeInsets.only(
                right: 10,
              ),
              isValid: ageValid,
            ),
          ),
          const Expanded(
            child: CustomDropDownButton(
              margin: EdgeInsets.only(
                left: 10,
              ),
              width: null,
              height: 55,
              itemList: [
                "여자",
                "남자",
              ],
            ),
          ),
        ],
        onTapUp: () {},
      ),
    );
  }
}
