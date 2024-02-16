import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/base_page.dart';

class WorkOutScreen extends StatelessWidget {
  const WorkOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePage(
      inputContent: [
        Text(
          "워크아웃 페이지임",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
      ],
    );
  }
}
