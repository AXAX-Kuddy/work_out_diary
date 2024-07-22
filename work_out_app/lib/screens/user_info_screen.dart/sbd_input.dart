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
  final bool fromDotsScreen;

  const SBDInput({
    super.key,
    this.fromDotsScreen = false,
  });

  @override
  State<SBDInput> createState() => _SBDInputState();
}

class _SBDInputState extends State<SBDInput> {
  late provider.UserInfo userInfo;
  late Function({required UserInfoField userInfoField, required dynamic value})
      setUserInfo;
  late Function({required SBDkeys key, required double value}) setSBD;
  late Function(num? userSBD) setDots;
  late Future<void> Function() savePreferences;

  final FocusNode squatFocusNode = FocusNode();
  final FocusNode benchFocusNode = FocusNode();
  final FocusNode deadFocusNode = FocusNode();

  final GlobalKey<FormState> squatKey = GlobalKey<FormState>();
  final GlobalKey<FormState> benchKey = GlobalKey<FormState>();
  final GlobalKey<FormState> deadKey = GlobalKey<FormState>();

  bool squatValid = false;
  bool benchValid = false;
  bool deadValid = false;

  double squatWeight = 0;
  double benchWeight = 0;
  double deadWeight = 0;

  double? dotsPoint;

  /// valid를 매개변수로 받은 값으로 변경합니다.
  /// 하위 클래스에서 valid를 변경할 수 없는 경우에 사용합니다.
  void squatValidChanger({required bool newValue, required double weight}) {
    setState(() {
      squatValid = newValue;
    });

    if (newValue) {
      squatWeight = weight;
      debugPrint("$squatWeight");

      updateDots();
    }
  }

  /// valid를 매개변수로 받은 값으로 변경합니다.
  /// 하위 클래스에서 valid를 변경할 수 없는 경우에 사용합니다.
  void benchValidChanger({required bool newValue, required double weight}) {
    setState(() {
      benchValid = newValue;
    });

    if (newValue) {
      benchWeight = weight;
      debugPrint("$benchWeight");

      updateDots();
    }
  }

  /// valid를 매개변수로 받은 값으로 변경합니다.
  /// 하위 클래스에서 valid를 변경할 수 없는 경우에 사용합니다.

  void deadValidChanger({required bool newValue, required double weight}) {
    setState(() {
      deadValid = newValue;
    });

    if (newValue) {
      deadWeight = weight;
      debugPrint("$deadWeight");

      updateDots();
    }
  }

  void updateDots() {
    final userSBD = squatWeight + benchWeight + deadWeight;

    setDots(userSBD);
    setState(() {
      dotsPoint = userInfo[UserInfoField.dotsPoint];
      debugPrint(" 닷츠 포인트 : ${dotsPoint.toString()}");
    });
  }

  @override
  void initState() {
    userInfo = context.read<provider.MainStoreProvider>().userInfo;
    setUserInfo = context.read<provider.MainStoreProvider>().setUserInfo;
    setSBD = context.read<provider.MainStoreProvider>().setSBD;
    savePreferences =
        context.read<provider.MainStoreProvider>().savePreferences;
    setDots = context.read<provider.MainStoreProvider>().setDots;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: widget.fromDotsScreen
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                ),
                color: palette.cardColorWhite,
              ),
            )
          : null,
      mainAxisAlignment: MainAxisAlignment.center,
      children: InputField.mainInput(
        context: context,
        endButton: true,
        escapeButton: !widget.fromDotsScreen,
        showDots: true,
        backButton: !widget.fromDotsScreen,
        backTo: const AgeInput(),
        title: widget.fromDotsScreen
            ? "당신의 SBD 기록을 입력해주세요!"
            : "마지막으로, 당신의 SBD 기록을 입력해주세요!",
        subtitle: "단위는 kg입니다. lb는 절대 사양",
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
        onTapUp: () async {
          CustomTextField.submit(squatKey);
          CustomTextField.submit(benchKey);
          CustomTextField.submit(deadKey);

          if (squatValid && benchValid && deadValid) {
            /// sbd 중량 설정
            setSBD(
              key: SBDkeys.squat,
              value: squatWeight,
            );
            setSBD(
              key: SBDkeys.benchPress,
              value: benchWeight,
            );
            setSBD(
              key: SBDkeys.deadLift,
              value: deadWeight,
            );

            /// 유저 정보 설정 여부
            setUserInfo(
              userInfoField: UserInfoField.isEdit,
              value: true,
            );

            await savePreferences();

            MainScreenRouter.removeUntilAndGo(context);
          }
        },
      ),
    );
  }
}

abstract class SBDField extends StatefulWidget {
  bool valid;
  final void Function({required bool newValue, required double weight})
      validChanger;

  final String hintText;
  final TextStyle? hintStyle;
  final FocusNode focusNode;
  final GlobalKey<FormState> formKey;
  final EdgeInsets? margin;

  SBDField({
    super.key,
    required this.validChanger,
    required this.hintText,
    this.hintStyle,
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
      hintStyle: widget.hintStyle,
      textStyle: const TextStyle(
        color: palette.cardColorWhite,
      ),
      validator: (value) {
        /// 값이 null이 아닐 때
        if (value != null) {
          /// 값이 비어있다면
          if (value.isEmpty) {
            setState(() {
              widget.validChanger(
                weight: 0.0,
                newValue: false,
              );
              widget.valid = false;
            });
            return "값이 비었어요!";
          }

          /// 값이 숫자가 아니라면
          if (double.tryParse(value) == null) {
            setState(() {
              widget.validChanger(
                weight: 0.0,
                newValue: false,
              );
              widget.valid = false;
            });
            return "숫자만 입력해주세요!";
          }

          /// 값이 숫자일 때
          if (double.tryParse(value) != null) {
            /// 비정상적인 값을 입력했을 경우
            if (double.parse(value) >= 1999 || double.parse(value) < 0) {
              setState(() {
                widget.validChanger(
                  weight: 0.0,
                  newValue: false,
                );
                widget.valid = false;
              });
              return "장난금지!";
            }

            /// 값이 0일 경우
            if (double.parse(value) == 0) {
              setState(() {
                widget.validChanger(
                  weight: 0.0,
                  newValue: false,
                );
                widget.valid = false;
              });
              return "0 이상으로 입력해주세요!";
            }
          }
        }

        /// 모든 예외를 통과했다면
        setState(() {
          widget.validChanger(
            weight: double.parse(value!),
            newValue: true,
          );
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
    super.hintStyle,
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
    super.hintStyle,
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
    super.hintStyle,
    required super.valid,
    required super.validChanger,
    required super.focusNode,
    required super.formKey,
    super.margin,
  });
}
