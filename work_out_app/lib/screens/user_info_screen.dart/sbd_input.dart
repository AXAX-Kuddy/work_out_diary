// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/user_info_screen.dart/age_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen_widgets/input.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/router/main_screen_router.dart';
import 'package:work_out_app/widgets/text_field/text_field.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/util/keys.dart';

class SBDInput extends StatefulWidget {
  const SBDInput({super.key});

  @override
  State<SBDInput> createState() => _SBDInputState();
}

class _SBDInputState extends State<SBDInput> {
  late provider.UserInfo userInfo;
  late Function({required UserInfoField userInfoField, required dynamic value})
      setUserInfo;

  final FocusNode squatFocusNode = FocusNode();
  final FocusNode benchFocusNode = FocusNode();
  final FocusNode deadFocusNode = FocusNode();

  final GlobalKey<FormState> squatKey = GlobalKey<FormState>();
  final GlobalKey<FormState> benchKey = GlobalKey<FormState>();
  final GlobalKey<FormState> deadKey = GlobalKey<FormState>();

  bool squatValid = false;
  bool benchValid = false;
  bool deadValid = false;

  /// valid를 매개변수로 받은 값으로 변경합니다.
  /// 하위 클래스에서 valid를 변경할 수 없는 경우에 사용합니다.
  void squatValidChanger(bool newValue) {
    setState(() {
      squatValid = newValue;
    });
  }

  /// valid를 매개변수로 받은 값으로 변경합니다.
  /// 하위 클래스에서 valid를 변경할 수 없는 경우에 사용합니다.
  void benchValidChanger(bool newValue) {
    setState(() {
      benchValid = newValue;
    });
  }

  /// valid를 매개변수로 받은 값으로 변경합니다.
  /// 하위 클래스에서 valid를 변경할 수 없는 경우에 사용합니다.
  void deadValidChanger(bool newValue) {
    setState(() {
      deadValid = newValue;
    });
  }

  @override
  void initState() {
    userInfo = context.read<provider.MainStoreProvider>().userInfo;
    setUserInfo = context.read<provider.MainStoreProvider>().setUserInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      mainAxisAlignment: MainAxisAlignment.center,
      children: InputField.mainInput(
        context: context,
        backTo: const AgeInput(),
        title: "마지막으로, 당신의 SBD 기록을 입력해주세요!",
        children: [
          Expanded(
            child: SquatField(
              hintText: "스쿼트",
              validChanger: squatValidChanger,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              formKey: squatKey,
              focusNode: squatFocusNode,
              valid: squatValid,
            ),
          ),
          Expanded(
            child: BenchField(
              hintText: "벤치프레스",
              validChanger: benchValidChanger,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              formKey: benchKey,
              focusNode: benchFocusNode,
              valid: benchValid,
            ),
          ),
          Expanded(
            child: DeadField(
              hintText: "데드리프트",
              validChanger: deadValidChanger,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              formKey: deadKey,
              focusNode: deadFocusNode,
              valid: deadValid,
            ),
          ),
        ],
        onTapUp: () {
          CustomTextField.submit(squatKey);
          CustomTextField.submit(benchKey);
          CustomTextField.submit(deadKey);

          if (squatValid && benchValid && deadValid) {
            MainScreenRouter.removeUntilAndGo(context);
          }
        },
      ),
    );
  }
}

abstract class SBDField extends StatefulWidget {
  bool valid;
  final void Function(bool newValue) validChanger;

  final String hintText;
  final FocusNode focusNode;
  final GlobalKey<FormState> formKey;
  final EdgeInsets? margin;

  SBDField({
    super.key,
    required this.validChanger,
    required this.hintText,
    required this.valid,
    required this.focusNode,
    required this.formKey,
    this.margin,
  });

  @override
  State<SBDField> createState() => _SBDFieldState();
}

class _SBDFieldState extends State<SBDField> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      margin: widget.margin,
      isValid: widget.valid,
      focusNode: widget.focusNode,
      formKey: widget.formKey,
      textInputType: TextInputType.number,
      hintText: widget.hintText,
      textStyle: const TextStyle(
        color: palette.cardColorWhite,
      ),
      validator: (value) {
        // 값이 null이 아닐 때
        if (value != null) {
          // 값이 비어있다면
          if (value.isEmpty) {
            setState(() {
              widget.validChanger(false);
              widget.valid = false;
            });
            return "값이 비었어요!";
          }

          // 값이 숫자가 아니라면
          if (double.tryParse(value) == null) {
            setState(() {
              widget.validChanger(false);
              widget.valid = false;
            });
            return "숫자만 입력해주세요!";
          }

          // 값이 숫자일 때
          if (double.tryParse(value) != null) {
            // 비정상적인 값을 입력했을 경우
            if (double.parse(value) >= 1999 || double.parse(value) <= 0) {
              setState(() {
                widget.validChanger(false);
                widget.valid = false;
              });
              return "장난금지!";
            }
          }
        }

        // 모든 예외를 통과했다면
        setState(() {
          widget.validChanger(true);
          widget.valid = true;
        });
        return null;
      },
      onFocusout: () {
        CustomTextField.submit(widget.formKey);
      },
      onFieldSubmitted: (value) {
        CustomTextField.submit(widget.formKey);
      },
    );
  }
}

class SquatField extends SBDField {
  SquatField({
    super.key,
    required super.hintText,
    required super.valid,
    required super.validChanger,
    required super.focusNode,
    required super.formKey,
    super.margin,
  });
}

class BenchField extends SBDField {
  BenchField({
    super.key,
    required super.hintText,
    required super.valid,
    required super.validChanger,
    required super.focusNode,
    required super.formKey,
    super.margin,
  });
}

class DeadField extends SBDField {
  DeadField({
    super.key,
    required super.hintText,
    required super.valid,
    required super.validChanger,
    required super.focusNode,
    required super.formKey,
    super.margin,
  });
}
