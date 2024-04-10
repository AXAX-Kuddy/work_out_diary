import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen_widgets.dart/routine_page.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/wide_button.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:go_router/go_router.dart';
import 'package:work_out_app/make_program.dart' as maked;

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  void createNewRoutine(BuildContext context) {
    String userName = context.read<provider.Store>().userInfo["userName"];

    maked.Program newProgram = maked.Program(
      programName: "$userName의 프로그램",
    );
    context.read<provider.UserProgramListStore>().addProgram(newProgram);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoutinePage(
          programInstance: newProgram,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: LineIcon.angleLeft(
            color: palette.cardColorWhite,
            size: 30,
          ),
        ),
        title: const Text(
          "Planning",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: LineIcon.plus(
                color: palette.cardColorWhite,
                size: 28,
              ),
              label: Text(
                "운동추가",
                style: TextStyle(
                  fontSize: 17,
                  color: palette.cardColorWhite,
                ),
              ),
            ),
          ],
        ),

        // WideButton(
        //   onTapUpFunction: () => context.read<provider.Store>().changePage(2),
        //   height: 80,
        //   inputContent: const [
        //     SizedBox(
        //       width: 10,
        //     ),
        //     Text(
        //       "루틴 없이 운동 바로 시작하기",
        //       style: TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     Spacer(),
        //     LineIcon(
        //       LineIcons.angleRight,
        //       size: 20,
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 15,
        // ),
        // WideButton(
        //   onTapUpFunction: () {
        //     createNewRoutine(context);
        //   },
        //   height: 80,
        //   inputContent: const [
        //     SizedBox(
        //       width: 10,
        //     ),
        //     Text(
        //       "새로운 루틴 만들기",
        //       style: TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     Spacer(),
        //     LineIcon(
        //       LineIcons.angleRight,
        //       size: 20,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
