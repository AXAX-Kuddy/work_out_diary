import 'package:flutter/material.dart';
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
    String? subtitle,
    required List<Widget> children,
    double? childrenWidth,
    double? childrenHeight,
    required VoidCallback onTapUp,
    bool backButton = true,
    bool endButton = false,
    Widget? backTo,
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
      if (subtitle != null)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: palette.cardColorWhite.withOpacity(0.7),
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
      Builder(builder: (context) {
        assert(!((backButton && backTo == null)),
            '뒤로가기 버튼이 true라면, 반드시 backTo가 null이 아니여야 함');

        return SizedBox(
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
                            page: backButton ? backTo! : const NameInput(),
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
                  if (endButton)
                    Expanded(
                      child: WideButtonBlack(
                        margin: backButton
                            ? const EdgeInsets.only(
                                left: 10,
                              )
                            : null,
                        onTapUpFunction: onTapUp,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "입력 완료!",
                                  style: TextStyle(
                                    color: palette.cardColorWhite,
                                  ),
                                ),
                                Spacer(),
                                LineIcon(
                                  color: palette.cardColorWhite,
                                  size: 20,
                                  LineIcons.check,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                        child: WideButtonBlack(
                      margin: backButton
                          ? const EdgeInsets.only(
                              left: 10,
                            )
                          : null,
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
                    )),
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
        );
      }),
    ];
  }
}
