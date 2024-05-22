import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_workout/select_work_out_page.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/keys.dart';

class PartList extends StatefulWidget {
  final Map<WorkoutListKeys, List<provider.WorkoutMenu>> workoutList;
  final void Function() onChanged;
  const PartList({
    super.key,
    required this.workoutList,
    required this.onChanged,
  });

  @override
  State<PartList> createState() => _PartListState();
}

class _PartListState extends State<PartList> {
  final List<String> list = ["하체", "등", "가슴", "어깨", "이두", "삼두"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 50,
            margin: const EdgeInsets.only(
              right: 20,
            ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: palette.cardColorYelGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  ChangePart.changeIndex(index);
                  widget.onChanged();
                });
              },
              child: Text(
                list[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
