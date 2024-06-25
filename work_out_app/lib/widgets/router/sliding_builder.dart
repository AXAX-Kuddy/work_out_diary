import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AnimationDirection {
  leftToRight,
  rightToLeft,
  bottomToTop,
}

class Direction {
  static PageRouteBuilder<Object?> createRoute(
    Widget page,
    AnimationDirection direction,
  ) {
    /// 슬라이딩 방향 설정
    Offset begin;

    switch (direction) {
      case AnimationDirection.bottomToTop:
        begin = const Offset(0.0, 1.0);
        break;

      case AnimationDirection.rightToLeft:
        begin = const Offset(-1.0, 0.0);
      case AnimationDirection.leftToRight:
      default:
        begin = const Offset(1.0, 0.0);
        break;
    }

    ///빌더 반환
    return PageRouteBuilder(
      /// 매개변수로 받은 페이지로 이동
      pageBuilder: (context, animation, secondaryAnimation) => page,

      /// 애니메이션 빌더
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =

            ///위 변수를 참고
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class SlidePage extends Navigator {
  const SlidePage({super.key});

  static Future<dynamic> goto({
    required BuildContext context,
    required Widget page,
    AnimationDirection animationDirection = AnimationDirection.leftToRight,
  }) {
    return Navigator.push(
      context,

      ///페이지 애니메이션 빌더
      Direction.createRoute(page, animationDirection),
    );
  }

  static Future<dynamic> removeUntiAndGoto({
    required BuildContext context,
    required Widget page,
    AnimationDirection animationDirection = AnimationDirection.leftToRight,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,

      ///페이지 애니메이션 빌더
      Direction.createRoute(page, animationDirection),
      (route) => false,
    );
  }
}
