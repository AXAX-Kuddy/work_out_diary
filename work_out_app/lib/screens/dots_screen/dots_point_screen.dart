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
  // late Animation<double> _dotsAnimation;

  late double maxWidth;

  @override
  void initState() {
    mainStoreProvider = context.read<provider.MainStoreProvider>();
    userInfo = mainStoreProvider.userInfo;

    double dotsPoint = userInfo[UserInfoField.dotsPoint];
    if (dotsPoint >= 500.0) {
      dotsPoint = 485;
    }

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _heightAnimation = Tween<double>(begin: 0, end: dotsPoint).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

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
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: SizedBox(
                          width: maxWidth,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            color: palette.cardColorGray,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 15,
                          height: 500,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _heightAnimation,
                        builder: (BuildContext context, Widget? child) {
                          return Positioned(
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: palette.cardColorYelGreen,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 15,
                              height: _heightAnimation.value,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        left: 25,
                        bottom: 0,
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: palette.cardColorWhite,
                              ),
                              width: 10,
                              height: 10,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              userInfo[UserInfoField.dotsPoint].toString(),
                              style: const TextStyle(
                                color: palette.cardColorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
