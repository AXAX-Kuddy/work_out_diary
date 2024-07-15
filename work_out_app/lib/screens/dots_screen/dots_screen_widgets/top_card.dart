import 'package:flutter/material.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/null_check_text.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';

class TopCard extends StatelessWidget {
  final provider.UserInfo userInfo;
  final provider.MainStoreProvider mainStoreProvider;

  const TopCard({
    super.key,
    required this.userInfo,
    required this.mainStoreProvider,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${userInfo[UserInfoField.userName]}님의 기록",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalDivider(
                color: palette.cardColorGray,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
            ],
          ),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SBD Total : ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                NullCheckText(
                  data: "${mainStoreProvider.sbdTotal}",
                  nullCheck: mainStoreProvider.sbdTotal,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VerticalDivider(
                  color: palette.cardColorGray,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
                const Text(
                  "DOTS Point : ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                NullCheckText(
                  data: "${userInfo[UserInfoField.dotsPoint]}",
                  nullCheck: userInfo[UserInfoField.dotsPoint],
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
