import 'package:work_out_app/util/palette.dart' as palette;
import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';

class AddCustomWorkoutScreen extends StatelessWidget {
  const AddCustomWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
          color: palette.cardColorWhite,
        ),
      ),
      children: const [
        Row(),
      ],
    );
  }
}
