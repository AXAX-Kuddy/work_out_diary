import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/base_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: "Pretendard",
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      inputContent: [
        // ignore: sized_box_for_whitespace
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: palette.cardColorYelGreen,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "유저 이름",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "초중급자",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: palette.tierMiddleLow,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
