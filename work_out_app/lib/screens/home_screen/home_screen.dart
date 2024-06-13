import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/database/database.dart' as db;
import 'package:work_out_app/provider/store.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen_widgets/page_router.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/todays_program.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/top_profile_card.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/sliding_up_panel/sliding_up_panel.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  db.Routine? panelCallingInstance = db.Routine(
    id: 0,
    routineName: "placeHold",
    date: DateTime.now(),
    isFavor: false,
    children: "",
  );
  List<Widget> panelItems = [];
  List<maked.Workout> panelCallingList = [];

  final SlidingUpPanelController panelController = SlidingUpPanelController();

  void handlePanelController({
    required PanelControllerCommand command,
    db.Routine? routine,
  }) {
    switch (command) {
      case PanelControllerCommand.spread:
        setState(() {
          panelCallingInstance = routine;
          routineChildrenDecode(routine!.children);
          panelController.expand();
        });

      case PanelControllerCommand.hide:
        setState(() {
          panelController.hide();
        });

      default:
        null;
    }
  }

  void routineChildrenDecode(String children) {
    dynamic decodeJson = jsonDecode(children);



    try {
      if (decodeJson is List<String>) {
        for (var workout in decodeJson) {
          maked.Workout instance =
              maked.Workout.toJsonDecode(jsonDecode(workout));
          panelCallingList.add(instance);
        }
      } else if (decodeJson is Map<String, dynamic>) {
        final maked.Workout workout = maked.Workout.toJsonDecode(decodeJson);
        print(workout);
        panelCallingList.add(workout);
      } else {
        throw TypeError();
      }
      print(panelCallingList);
    } catch (event) {
      setState(() {
        panelItems.add(ErrorWidget("타입에러가 발생하였습니다. 발생경위 : $event"));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      floatingActionButton: SizedBox(
        width: 180,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: palette.bgFadeColor,
          onPressed: () {
            PlanningScreenRouter.go(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LineIcon(
                  LineIcons.angleLeft,
                  color: palette.cardColorWhite,
                  size: 30,
                ),
                Text(
                  "운동 기록",
                  style: TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      slidingUpPanelWidget: CustomSlidingUpPanelWidget(
        onlyAnchor: false,
        showDragHandle: false,
        controller: panelController,
        onStatusChanged: (status) {
          if (status == SlidingUpPanelStatus.anchored) {
            panelController.hide();
          }
        },
        children: [
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  panelCallingInstance?.routineName ?? "placeHold",
                  style: const TextStyle(
                    color: palette.colorWhite,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    panelController.hide();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: palette.colorRed,
                  ),
                )
              ],
            );
          }),
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: panelItems,
            );
          }),
        ],
      ),
      children: [
        ProfileCard(),
        const SizedBox(
          height: 15,
        ),
        TodayWorkOutCard(
          handlePanelController: handlePanelController,
        ),
      ],
    );
  }
}

class PanelItem extends StatelessWidget {
  final maked.Workout workoutInstance;

  const PanelItem({super.key, required this.workoutInstance});

  @override
  Widget build(BuildContext context) {
    return Text(
      workoutInstance.name!,
    );
  }
}
