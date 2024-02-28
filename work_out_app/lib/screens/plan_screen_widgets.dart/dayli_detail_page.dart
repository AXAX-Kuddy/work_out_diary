import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

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
        setState(() {});
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

  void addSets(setNum) {
    widget.workouts.add(
      {
        "$setNum세트": [
          {
            "중량": "",
            "RPE": "",
          },
        ],
      },
    );
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
                        height: 10,
                      ),
                      RpeInput(
                        focusNode: _focusNodes[index],
                        label: "타겟 RPE",
                        workouts: widget.workouts,
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

class RpeInput extends StatefulWidget {
  final FocusNode focusNode;
  final String label;
  List workouts;

  RpeInput({
    Key? key,
    required this.focusNode,
    required this.label,
    required this.workouts,
  }) : super(key: key);

  @override
  State<RpeInput> createState() => _RpeInputState();
}

class _RpeInputState extends State<RpeInput> {
  List<String> rpeList = [
    "5",
    "5.5",
    "6",
    "6.5",
    "7",
    "7.5",
    "8",
    "8.5",
    "9",
    "9.5",
    "10"
  ];
  String? selectValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
        // Container(
        //   width: 85,
        //   height: 50,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15),
        //     border: Border.all(
        //       color: widget.focusNode.hasFocus
        //           ? palette.cardColorYelGreen
        //           : Colors.transparent,
        //     ),
        //     color: widget.focusNode.hasFocus
        //         ? palette.bgColor
        //         : palette.bgFadeColor,
        //   ),
        //   child:
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            items: rpeList
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectValue,
            onChanged: (value) {
              setState(() {
                selectValue = value;
              });
              print(widget.workouts);
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 80,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: palette.bgFadeColor,
              ),
              elevation: 2,
            ),
            iconStyleData: IconStyleData(
              icon: const LineIcon.angleRight(),
              iconSize: 14,
              iconEnabledColor: palette.cardColorWhite,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: palette.bgColor,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
        // ),
      ],
    );
  }
}
