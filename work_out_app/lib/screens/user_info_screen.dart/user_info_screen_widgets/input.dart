import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/user_info_screen.dart/name_input.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/router/main_screen_router.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/widgets/router/sliding_builder.dart';

class InputField {
  static List<Widget> mainInput({
    required BuildContext context,
    required String title,
    required List<Widget> children,
    double? childrenWidth,
    double? childrenHeight,
    required VoidCallback onTapUp,
    bool backButton = true,

  }) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: palette.cardColorWhite,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        width: childrenWidth,
        height: childrenHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (backButton)
                  Expanded(
                    child: WideButton(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      onTapUpFunction: () {
                        SlidePage.removeUntiAndGoto(
                          context: context,
                          animationDirection: AnimationDirection.rightToLeft,
                          page: const NameInput(),
                        );
                      },
                      child: const Row(
                        children: [
                          LineIcon(
                            size: 20,
                            LineIcons.angleLeft,
                          ),
                          Spacer(),
                          Text("뒤로가기"),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: WideButton(
                    margin: backButton
                        ? const EdgeInsets.only(
                            left: 10,
                          )
                        : null,
                    unTapColor: palette.bgFadeColor,
                    tapColor: palette.bgColor,
                    tapBorderColor: palette.cardColorYelGreen,
                    onTapUpFunction: onTapUp,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "다음으로",
                              style: TextStyle(
                                color: palette.cardColorWhite,
                              ),
                            ),
                            Spacer(),
                            LineIcon(
                              color: palette.cardColorWhite,
                              size: 20,
                              LineIcons.angleRight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Provider.of<provider.MainStoreProvider>(context,
                            listen: false)
                        .setUserInfo(
                      userInfoField: UserInfoField.isEdit,
                      value: true,
                    );
                    MainScreenRouter.removeUntilAndGo(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        "정보입력을 생략하고 바로 시작하기",
                        style: TextStyle(
                          color: palette.cardColorWhite.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      LineIcon(
                        LineIcons.dumbbell,
                        size: 18,
                        color: palette.cardColorWhite.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
