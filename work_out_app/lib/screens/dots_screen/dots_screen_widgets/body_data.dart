import 'package:flutter/material.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/null_check_text.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';

class BodyData extends StatelessWidget {
  final provider.UserInfo userInfo;

  const BodyData({
    super.key,
    required this.userInfo,
  });

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
                "${userInfo[UserInfoField.userName]}님의 신체 데이터",
                style: const TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                data: userInfo[UserInfoField.isFemale] ? "여성" : "남성",
                nullCheck: userInfo[UserInfoField.isFemale],
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
                data: "${userInfo[UserInfoField.height]} Cm",
                nullCheck: userInfo[UserInfoField.height],
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
                data: "${userInfo[UserInfoField.weight]} Kg",
                nullCheck: userInfo[UserInfoField.weight],
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
