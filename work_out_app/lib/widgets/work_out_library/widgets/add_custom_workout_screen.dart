import 'package:drift/drift.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/database/database.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/widgets/drop_downs/drop_down.dart';
import '../../text_field/text_field.dart';

class AddCustomWorkoutScreen extends StatefulWidget {
  final Future<int> Function() categorize;

  const AddCustomWorkoutScreen({
    super.key,
    required this.categorize,
  });

  @override
  State<AddCustomWorkoutScreen> createState() => _AddCustomWorkoutScreenState();
}

class _AddCustomWorkoutScreenState extends State<AddCustomWorkoutScreen> {
  final AppDatabase db = AppDatabase();

  final FocusNode nameFocusNode = FocusNode();
  final GlobalKey<FormState> nameFormkey = GlobalKey<FormState>();

  final List<String> typeList = ["바벨", "덤벨", "머신", "맨몸", "기타"];
  final List<String> partList = [
    "하체",
    "등",
    "가슴",
    "어깨",
    "이두",
    "삼두",
    "유산소",
    "기타"
  ];

  String? workoutName;
  bool nameValid = false;

  WorkoutListKeys? target;
  bool targetValid = false;

  String? exerciseType;
  bool typeValid = false;

  bool? showE1rm;
  bool e1rmValid = false;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      mainAxisAlignment: MainAxisAlignment.center,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
          color: palette.cardColorWhite,
        ),
      ),
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "사용자 정의 운동 추가",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: palette.cardColorWhite,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              width: 300,
              height: 70,
              hintText: "운동 이름",
              hintStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              textStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              isValid: nameValid,
              focusNode: nameFocusNode,
              formKey: nameFormkey,
              onFocusout: () {
                CustomTextField.submit(nameFormkey);
              },
              onFieldSubmitted: (String value) {
                CustomTextField.submit(nameFormkey);
              },
              validator: (String? value) {
                final RegExp regex = RegExp(r'^[a-zA-Z0-9가-힣\s]*$');

                /// 값이 비어있다면
                if (value == null || value.isEmpty) {
                  setState(() {
                    nameValid = false;
                  });
                  return "이름을 입력해주세요!";
                }

                /// 이름이 20글자를 초과했다면
                if (value.length > 20) {
                  setState(() {
                    nameValid = false;
                  });
                  return "이름은 20글자 이하로 해주세요!";
                }

                /// 글자 이외에 다른 문자가 들어갈 경우
                if (!regex.hasMatch(value)) {
                  setState(() {
                    nameValid = false;
                  });
                  return "특수문자를 제외해야해요!";
                }

                /// 모든 예외를 통과했다면
                setState(() {
                  workoutName = value;
                  nameValid = true;
                  debugPrint("$workoutName");
                });

                return null;
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropDownButton(
              width: 300,
              hint: "타겟 부위",
              textStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              itemList: partList,
              itemTextStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              onChanged: (String? value) {
                setState(() {
                  if (value == partList[0]) {
                    target = WorkoutListKeys.leg;
                  } else if (value == partList[1]) {
                    target = WorkoutListKeys.back;
                  } else if (value == partList[2]) {
                    target = WorkoutListKeys.chest;
                  } else if (value == partList[3]) {
                    target = WorkoutListKeys.shoulder;
                  } else if (value == partList[4]) {
                    target = WorkoutListKeys.biceps;
                  } else if (value == partList[5]) {
                    target = WorkoutListKeys.triceps;
                  } else if (value == partList[6]) {
                    target = WorkoutListKeys.cardio;
                  } else if (value == partList[7]) {
                    target = WorkoutListKeys.other;
                  }
                  debugPrint("$target");
                  targetValid = true;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropDownButton(
              hint: "사용 기구",
              textStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              itemList: typeList,
              itemTextStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              onChanged: (String? value) {
                setState(() {
                  if (value == typeList[0]) {
                    exerciseType = ExerciseType.barbell;
                  } else if (value == typeList[1]) {
                    exerciseType = ExerciseType.dumbbell;
                  } else if (value == typeList[2]) {
                    exerciseType = ExerciseType.machine;
                  } else if (value == typeList[3]) {
                    exerciseType = ExerciseType.bodyweight;
                  } else if (value == typeList[4]) {
                    exerciseType = ExerciseType.other;
                  }
                  debugPrint("$exerciseType");
                  typeValid = true;
                });
              },
            ),
            const SizedBox(
              width: 40,
            ),
            CustomDropDownButton(
              hint: "e1RM 표시",
              textStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              itemList: const ["표시", "안함"],
              itemTextStyle: const TextStyle(
                color: palette.cardColorWhite,
              ),
              onChanged: (String? value) {
                setState(() {
                  if (value == "표시") {
                    showE1rm = true;
                  } else {
                    showE1rm = false;
                  }
                  debugPrint("$showE1rm");
                  e1rmValid = true;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        WideButtonBlack(
          width: 300,
          child: const Row(
            children: [
              Text(
                "운동을 라이브러리에 추가",
                style: TextStyle(
                  color: palette.cardColorWhite,
                ),
              ),
              Spacer(),
              LineIcon(
                LineIcons.angleRight,
                color: palette.cardColorWhite,
              ),
            ],
          ),
          onTapUpFunction: () {
            CustomTextField.submit(nameFormkey);

            if (nameValid && typeValid && e1rmValid && targetValid) {
              db.insertWorkoutMenu(
                WorkoutMenuCompanion.insert(
                  name: workoutName!,
                  showE1rm: Value(showE1rm!),
                  exerciseType: Value(exerciseType!),
                  part: target!,
                  custom: const Value(true),
                ),
              );
              widget.categorize();

              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
