import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;

class DailyDetail extends StatefulWidget {
  final int dayNum;
  final List workouts;
  const DailyDetail({
    super.key,
    required this.dayNum,
    required this.workouts,
  });

  @override
  State<DailyDetail> createState() => _DailyDetailState();
}

class _DailyDetailState extends State<DailyDetail> {
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.workouts.length, (index) => FocusNode());
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {}); // 포커스 상태가 변경될 때마다 UI를 업데이트합니다.
      });
    }
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          inputContent: [
            Text(
              "${widget.dayNum + 1}일차 세부 운동 설정",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return WidgetsBox(
                backgroundColor: palette.bgColor,
                border: Border.all(
                  color: palette.cardColorYelGreen,
                ),
                horizontalAxis: MainAxisAlignment.center,
                verticalAxis: CrossAxisAlignment.center,
                inputContent: [
                  Column(
                    children: [
                      Text(
                        "${widget.workouts[index]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: palette.cardColorWhite,
                        ),
                      ),
                      const Divider(
                        // color: palette.cardColorWhite,
                        thickness: 1,
                        height: 30,
                      ),
                      InputField(
                        focusNode: _focusNodes[index],
                        label: "타겟 RPE",
                        maxLength: 3,
                      ),
                    ],
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: widget.workouts.length,
            shrinkWrap: true,
          ),
        )
      ],
    );
  }
}

class InputField extends StatefulWidget {
  final FocusNode focusNode;

  final String label;
  final int? maxLength;

  const InputField({
    Key? key,
    required this.focusNode,
    required this.label,
    this.maxLength,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: palette.cardColorWhite,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.focusNode.hasFocus
                  ? palette.cardColorYelGreen
                  : Colors.transparent,
            ),
            color: widget.focusNode.hasFocus
                ? palette.bgColor
                : palette.bgFadeColor,
          ),
          child: TextField(
            onChanged: (value) {},
            focusNode: widget.focusNode,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            textAlign: TextAlign.center,
            maxLength: widget.maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            style: TextStyle(
              color: palette.cardColorWhite,
            ),
          ),
        ),
      ],
    );
  }
}
