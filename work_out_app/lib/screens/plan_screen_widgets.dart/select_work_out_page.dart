import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class SelectWorkOut extends StatefulWidget {
  List workouts;
  Function onWorkoutChanged;
  SelectWorkOut({
    super.key,
    required this.workouts,
    required this.onWorkoutChanged,
  });

  @override
  State<SelectWorkOut> createState() => _SelectWorkOutState();
}

class _SelectWorkOutState extends State<SelectWorkOut> {
  List? workOutList;
  DateTime? lastBackPressed;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    workOutList = context.watch<provider.WorkOutListStore>().workOut;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
          lastBackPressed = now;
          AnimatedSnackBar(
            mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            duration: const Duration(seconds: 4),
            builder: ((context) {
              return MaterialAnimatedSnackBar(
                titleText: "뒤로가면 모든 선택 항목이 초기화 됩니다.",
                messageText: "한번 더 누르면 뒤로 갑니다.",
                type: AnimatedSnackBarType.info,
                iconData: LineIcons.check,
                backgroundColor: palette.cardColorYelGreen,
                foregroundColor: Colors.black,
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                ),
                messageTextStyle: const TextStyle(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(40),
              );
            }),
          ).show(context);
          setState(() {
            widget.workouts = [];
          });
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: BasePage(
        children: [
          WidgetsBox(
            backgroundColor: palette.bgColor,
            height: 50,
            inputContent: const [
              Text(
                "Select Your Work-Out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return SelectBox(
                  workOutName: workOutList?[index] ?? "불러오지 못함",
                  workouts: widget.workouts,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: workOutList?.length ?? 1,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onWorkoutChanged(widget.workouts);
            },
            child: const Text("운동 추가하기"),
          ),
        ],
      ),
    );
  }
}

class SelectBox extends StatefulWidget {
  final String workOutName;
  List workouts;

  SelectBox({
    super.key,
    required this.workOutName,
    required this.workouts,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool checker = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (checker == false) {
          checker = true;
          setState(() {
            widget.workouts.add(widget.workOutName);
          });
        } else if (checker == true) {
          checker = false;
          setState(() {
            widget.workouts.remove(widget.workOutName);
          });
        }
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: checker ? palette.cardColorYelGreen : palette.cardColorWhite,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Text(
              widget.workOutName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Icon(
              checker ? LineIcons.check : LineIcons.circle,
              color:
                  checker ? palette.cardColorYelGreen : palette.cardColorWhite,
            )
          ],
        ),
      ),
    );
  }
}
