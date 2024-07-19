import 'package:flutter/material.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;

class DotsGauge extends StatefulWidget {
  final provider.UserInfo userInfo;

  const DotsGauge({
    super.key,
    required this.userInfo,
  });

  @override
  State<DotsGauge> createState() => _DotsGaugeState();
}

class _DotsGaugeState extends State<DotsGauge> with TickerProviderStateMixin {
  late AnimationController _heightAnimationController;
  late Animation<double> _heightAnimation;

  late AnimationController _nextTierAnimationController;
  late Animation<double> _nextTierAnimation;

  late AnimationController _gaugeTierNameAnimationController;
  late Animation<double> _gaugeTierNameAnimation;

  /// 게이지 배경용
  late double maxWidth;

  late double dotsPoint;
  late Map<String, dynamic> leftoverTier;
  late List<Widget> nextTier;

  @override
  void initState() {
    dotsPoint = widget.userInfo[UserInfoField.dotsPoint];

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
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
                  height: 20,
                  child: Text(
                    "당신은 진정한 인자강... ㄷㄷ",
                    style: TextStyle(
                      color: palette.cardColorWhite.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ];
    }

    _heightAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _heightAnimation = Tween<double>(begin: 0, end: dotsPoint).animate(
      CurvedAnimation(
        parent: _heightAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _nextTierAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _nextTierAnimation =
        Tween<double>(begin: 0, end: 1).animate(_nextTierAnimationController);

    _gaugeTierNameAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _gaugeTierNameAnimation =
        Tween<double>(begin: 0, end: 1).animate(_nextTierAnimationController);

    _heightAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextTierAnimationController.forward();
        _gaugeTierNameAnimationController.forward();
      }
    });

    _heightAnimationController.forward();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    maxWidth = MediaQuery.of(context).size.width * 0.7;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TierGaugeName(
          gaugeTierNameAnimation: _gaugeTierNameAnimation,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Stack(
              children: [
                /// 배경용
                Positioned(
                  child: SizedBox(
                    width: maxWidth,
                  ),
                ),

                const TierGauge(),

                TierGaugeMarker(
                  heightAnimation: _heightAnimation,
                  nextTierAnimation: _nextTierAnimation,
                  nextTier: nextTier,
                  userInfo: widget.userInfo,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TierGaugeName extends StatelessWidget {
  const TierGaugeName({
    super.key,
    required Animation<double> gaugeTierNameAnimation,
  }) : _gaugeTierNameAnimation = gaugeTierNameAnimation;

  final Animation<double> _gaugeTierNameAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _gaugeTierNameAnimation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _gaugeTierNameAnimation.value,
            child: const Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "프로",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: palette.tierVeryHigh,
                          ),
                        ),
                        Text(
                          "리프터",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: palette.tierVeryHigh,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "어드밴스드",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: palette.tierHigh,
                          ),
                        ),
                        Text(
                          "리프터",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: palette.tierHigh,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "시니어",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: palette.tierMiddleHigh,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "아마추어",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: palette.tierMiddle,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      "주니어",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: palette.tierMiddleLow,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      "비기너",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: palette.tierLow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class TierGaugeMarker extends StatelessWidget {
  const TierGaugeMarker({
    super.key,
    required Animation<double> heightAnimation,
    required this.userInfo,
    required Animation<double> nextTierAnimation,
    required this.nextTier,
  })  : _heightAnimation = heightAnimation,
        _nextTierAnimation = nextTierAnimation;

  final Animation<double> _heightAnimation;
  final provider.UserInfo userInfo;
  final Animation<double> _nextTierAnimation;
  final List<Widget> nextTier;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _heightAnimation,
        builder: (BuildContext context, Widget? child) {
          double adjustedHeight = (_heightAnimation.value / 500) * 490;
          return Positioned(
            left: 1,
            bottom: adjustedHeight >= 500 ? 480 : adjustedHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 22.5,
                    ),
                    Text(
                      "NOW ${_heightAnimation.value.toStringAsFixed(2).toString()} PT",
                      style: const TextStyle(
                        color: palette.cardColorWhite,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 22.5,
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
                      width: 22.5,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      width: 10,
                    ),
                    AnimatedBuilder(
                      animation: _nextTierAnimation,
                      builder: (BuildContext context, Widget? child) {
                        return Opacity(
                          opacity: _nextTierAnimation.value,
                          child: Column(
                            children: nextTier,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class TierGauge extends StatelessWidget {
  const TierGauge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Column(
        children: [
          const SizedBox(
            height: 90,
          ),
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
    );
  }
}
