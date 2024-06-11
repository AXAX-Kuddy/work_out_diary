import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/base_screen/base_page.dart';

class DotsPointScreen extends StatelessWidget {
  const DotsPointScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BasePage(
      children: [
        Text(
          "닷츠포인트 페이지임",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
      ],
    );
  }
}
