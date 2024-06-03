import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/util/palette.dart' as palette;

class WorkoutListViewer extends StatefulWidget {
  final List<provider.WorkoutMenu> list;
  final void Function(
      {required int command,
      required provider.WorkoutMenu workout}) managementTempoList;

  const WorkoutListViewer({
    super.key,
    required this.list,
    required this.managementTempoList,
  });

  @override
  State<WorkoutListViewer> createState() => _WorkoutListViewerState();
}

class _WorkoutListViewerState extends State<WorkoutListViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.list[index].name,
                style: const TextStyle(
                  fontSize: 15,
                  color: palette.cardColorWhite,
                ),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    widget.managementTempoList(
                      command: 0,
                      workout: widget.list[index],
                    );
                  },
                  icon: const LineIcon(
                    LineIcons.trash,
                    size: 20,
                    color: Colors.red,
                  )),
            ],
          );
        },
      ),
    );
  }
}
