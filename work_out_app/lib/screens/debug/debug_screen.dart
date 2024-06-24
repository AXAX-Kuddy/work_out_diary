import 'package:flutter/material.dart';
import 'package:work_out_app/main.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MyApp();
                  }),
                  (route) => false,
                );
              },
              child: const Text("운동종료"),
            ),
          ],
        ),
      ],
    );
  }
}
