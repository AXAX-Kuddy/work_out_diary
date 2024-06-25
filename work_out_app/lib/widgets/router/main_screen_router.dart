import 'package:flutter/material.dart';
import 'package:work_out_app/main.dart';

class MainScreenRouter extends Navigator {
  const MainScreenRouter({
    super.key,
  });

  static Future<dynamic> removeUntilAndGo(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const MyApp();
        },
      ),
      (route) => false,
    );
  }
}
