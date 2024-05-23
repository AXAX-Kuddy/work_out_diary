import 'package:flutter/material.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/widgets/work_out_library/work_out_library.dart';

class SelectWorkoutPage extends StatefulWidget {
  final provider.RoutineProvider routineProvider;
  const SelectWorkoutPage({
    super.key,
    required this.routineProvider,
  });

  @override
  State<SelectWorkoutPage> createState() => _SelectWorkoutPageState();
}

class _SelectWorkoutPageState extends State<SelectWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return WorkoutLibrary(
      bottomChildren: [
        WideButton(
          onTapUpFunction: () {
            (List<maked.Workout> selectList) {
              for (int i = 0; i < selectList.length; i++) {
                widget.routineProvider.addUserSelectWorkout(selectList[i]);
                // addWorkout(selectList[i]);
              }
            };
            setState(() {
              widget.routineProvider.todayWorkouts;
            });
          },
          children: const [
            Text("운동 추가하기"),
          ],
        ),
      ],
    );
  }
}
