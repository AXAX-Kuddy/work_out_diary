import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      inputContent: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          verticalAxis: CrossAxisAlignment.center,
          inputContent: const [
            Text(
              "Create Your Program",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        WidgetsBox(
          backgroundColor: palette.bgColor,
          width: MediaQuery.of(context).size.width,
          horizontalAxis: MainAxisAlignment.start,
          inputContent: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "1주차",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Text('item $index'),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: context
                        .read<provider.UserProgramListStore>()
                        .userSelectWorkOut
                        .length,
                  )
                ],
              ),
            )
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) {
                return const SelectWorkOut();
              })),
            );
          },
          child: const Text("+운동 추가"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("+주차 추가"),
        ),
      ],
    );
  }
}
