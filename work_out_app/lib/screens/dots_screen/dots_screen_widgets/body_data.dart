import 'package:flutter/material.dart';
import 'package:work_out_app/screens/user_info_screen.dart/age_input.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/null_check_text.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

class BodyData extends StatefulWidget {
  final provider.UserInfo userInfo;

  const BodyData({
    super.key,
    required this.userInfo,
  });

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      backgroundColor: palette.cardColorGray,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${widget.userInfo[UserInfoField.userName]}님의 신체 데이터",
                style: const TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  SlidePage.goto(
                    animationDirection: AnimationDirection.bottomToTop,
                    context: context,
                    page: const AgeInput(
                      fromDotsScreen: true,
                    ),
                  );
                },
                icon: const LineIcon(
                  LineIcons.pen,
                  size: 20,
                  color: palette.cardColorWhite,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "성별 : ",
                style: TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 16,
                ),
              ),
              NullCheckText(
                data: widget.userInfo[UserInfoField.sex],
                nullCheck: widget.userInfo[UserInfoField.sex],
                textStyle: const TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "신장 : ",
                style: TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 16,
                ),
              ),
              NullCheckText(
                data: "${widget.userInfo[UserInfoField.height]} Cm",
                nullCheck: widget.userInfo[UserInfoField.height],
                textStyle: const TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "체중 : ",
                style: TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 16,
                ),
              ),
              NullCheckText(
                data: "${widget.userInfo[UserInfoField.weight]} Kg",
                nullCheck: widget.userInfo[UserInfoField.weight],
                textStyle: const TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
