import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/work_out_library/work_out_library.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/util/keys.dart';

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
  final List<String> list = ["하체", "등", "가슴", "어깨", "이두", "삼두", "유산소", "기타"];

  Color changeFocusBorderColor({
    required int index,
    required int focusTab,
  }) {
    if (index == focusTab) {
      return palette.cardColorYelGreen;
    } else {
      return palette.bgFadeColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                ChangePart.changeIndex(index);
                widget.onChanged();
              });
            },
            child: Container(
              key: GlobalKey(),
              width: 65,
              margin: const EdgeInsets.only(
                right: 20,
              ),
              // padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: changeFocusBorderColor(
                    index: index,
                    focusTab: ChangePart.index,
                  ),
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                list[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
