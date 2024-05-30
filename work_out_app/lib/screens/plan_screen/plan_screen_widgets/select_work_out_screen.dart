import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/work_out_library/work_out_library.dart';

class SelectWorkoutPage extends StatefulWidget {
  const SelectWorkoutPage({
    super.key,
  });

  @override
  State<SelectWorkoutPage> createState() => _SelectWorkoutPageState();
}

class _SelectWorkoutPageState extends State<SelectWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return const WorkoutLibrary(
      showAddPlanningScreen: true,
    );
  }
}
