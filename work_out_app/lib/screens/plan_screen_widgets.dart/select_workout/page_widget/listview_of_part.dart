import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:work_out_app/palette.dart' as palette;

class PartList extends StatefulWidget {
  final Map<String, List<provider.WorkoutMenu>> workoutList;
  const PartList({
    super.key,
    required this.workoutList,
  });

  @override
  State<PartList> createState() => _PartListState();
}

class _PartListState extends State<PartList> {
  late final List<String> list = widget.workoutList.keys.toList();

  @override
  void initState() {
    super.initState();
  }

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
              onTap: () {},
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
