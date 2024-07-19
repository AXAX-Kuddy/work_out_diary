import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/body_data.dart';
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/dots_gauge_bar.dart';
import 'package:work_out_app/screens/dots_screen/dots_screen_widgets/top_card.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/widgets/base_screen/base_page.dart';

class DotsPointScreen extends StatefulWidget {
  const DotsPointScreen({
    super.key,
  });

  @override
  State<DotsPointScreen> createState() => _DotsPointScreenState();
}

class _DotsPointScreenState extends State<DotsPointScreen> {
  late provider.MainStoreProvider mainStoreProvider;
  late provider.UserInfo userInfo;

  @override
  void initState() {
    mainStoreProvider = context.read<provider.MainStoreProvider>();
    userInfo = mainStoreProvider.userInfo;

    super.initState();
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
        DotsGauge(
          userInfo: userInfo,
        ),
        
      ],
    );
  }
}
