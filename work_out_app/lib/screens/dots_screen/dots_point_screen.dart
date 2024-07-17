import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/body_data.dart';
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/null_check_text.dart';
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/top_card.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';

class DotsPointScreen extends StatefulWidget {
  const DotsPointScreen({
    super.key,
  });

  @override
  State<DotsPointScreen> createState() => _DotsPointScreenState();
}

class _DotsPointScreenState extends State<DotsPointScreen>
    with SingleTickerProviderStateMixin {
  late provider.MainStoreProvider mainStoreProvider;
  late provider.UserInfo userInfo;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  /// 게이지 배경용
  late double maxWidth;

  late double dotsPoint;
  late Map<String, dynamic> leftoverTier;
  late List<Widget> nextTier;

  double endPoint(double dotsPoint) {
    if (dotsPoint >= 500) {
      return 490;
    } else {
      return dotsPoint;
    }
  }

  @override
  void initState() {
    mainStoreProvider = context.read<provider.MainStoreProvider>();
    userInfo = mainStoreProvider.userInfo;
    dotsPoint = 890;

    if (userInfo[UserInfoField.dotsPoint] >= 500) {
      dotsPoint = 490;
    }

    if (dotsPoint <= 450) {
      leftoverTier = {
        "name": Tier.tierList[Tier.userTier(dotsPoint) + 1],
        "point": Tier.leftoverTierPoints(dotsPoint),
        "color": Tier.colorList[Tier.userTier(dotsPoint) + 1],
      };

      nextTier = [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 17.5,
                ),
                const Text(
                  "다음 티어, ",
                  style: TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 16,
                  ),
                ),
                Text(
                  leftoverTier["name"],
                  style: TextStyle(
                    color: leftoverTier["color"],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "까지",
                  style: TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 17.5,
                ),
                Text(
                  "${leftoverTier["point"].toStringAsFixed(2).toString()}PT",
                  style: const TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ];
    } else {
      leftoverTier = {
        "name": Tier.selectTierName(dotsPoint),
        "point": dotsPoint,
        "color": Tier.selectTierColor(dotsPoint),
      };

      nextTier = [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 17.5,
                ),
                Text(
                  "축하합니다! 최고 티어 달성!!",
                  style: TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 17.5,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ];
    }

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _heightAnimation =
        Tween<double>(begin: 0, end: endPoint(dotsPoint)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("종료");
      }
    });

    _animationController.forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    maxWidth = MediaQuery.of(context).size.width * 0.7;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BasePageWithScroll(
      children: [
        TopCard(
          userInfo: userInfo,
          mainStoreProvider: mainStoreProvider,
        ),
        const SizedBox(
          height: 20,
        ),
        BodyData(
          userInfo: userInfo,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  /// 배경용
                  Positioned(
                    child: SizedBox(
                      width: maxWidth,
                    ),
                  ),
                  Positioned(
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: palette.tierVeryHigh,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          width: 15,
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: palette.tierHigh,
                          ),
                          width: 15,
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: palette.tierMiddleHigh,
                          ),
                          width: 15,
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: palette.tierMiddle,
                          ),
                          width: 15,
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: palette.tierMiddleLow,
                          ),
                          width: 15,
                          height: 100,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: palette.tierLow,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          width: 15,
                          height: 200,
                        ),
                      ],
                    ),
                  ),

                  AnimatedBuilder(
                      animation: _heightAnimation,
                      builder: (BuildContext context, Widget? child) {
                        double adjustedHeight =
                            (_heightAnimation.value / 500) * 490;
                        return Positioned(
                          left: 1.75,
                          bottom: adjustedHeight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 17.5,
                                  ),
                                  Text(
                                    "${userInfo[UserInfoField.userName]}님의 현재 티어는 ",
                                    style: const TextStyle(
                                      color: palette.cardColorWhite,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 17.5,
                                  ),
                                  Text(
                                    Tier.selectTierName(_heightAnimation.value),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Tier.selectTierColor(
                                        _heightAnimation.value,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ...nextTier,
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: palette.cardColorWhite,
                                    ),
                                    width: 12.5,
                                    height: 12.5,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "NOW ${_heightAnimation.value.toStringAsFixed(2).toString()} PT",
                                    style: const TextStyle(
                                      color: palette.cardColorWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
