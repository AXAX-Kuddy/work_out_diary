// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_out_app/database/database.dart';

import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/calendar_custom/calendar_builders.dart';
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/calendar_custom/calendar_style.dart';

import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/header_style.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/widgets/buttons/cancel_and_enter_buttons.dart';
import 'package:work_out_app/widgets/buttons/trash_can_button.dart';
import 'package:work_out_app/widgets/dialog/custom_dialog.dart';
import 'package:work_out_app/widgets/grid_loading_circle/loading_circle.dart';

import '../../util/util.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final AppDatabase database = AppDatabase();
  late Future<List<Routine>> routineList;
  late provider.UserInfo userInfo;
  late provider.RoutineProvider routineProvider;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Routine> _selectedDayRoutines = [];
  Map<DateTime, List<Routine>> _events = {};

  void _loadEvents() async {
    final routines = await routineList;
    setState(() {
      _events = {};
      for (var routine in routines) {
        final eventDate =
            DateTime(routine.date.year, routine.date.month, routine.date.day);
        if (_events[eventDate] == null) {
          _events[eventDate] = [];
        }
        _events[eventDate]!.add(routine);
      }
      _updateSelectedDayRoutines();
    });
  }

  void _updateSelectedDayRoutines() {
    setState(() {
      _selectedDayRoutines = _events[DateTime(
              _selectedDay.year, _selectedDay.month, _selectedDay.day)] ??
          [];
    });
  }

  @override
  void initState() {
    super.initState();
    userInfo = context.read<provider.MainStoreProvider>().getUserInfo();
    routineProvider = context.read<provider.RoutineProvider>();
    routineList = database.getRoutines();
    _loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        Text(
          "${userInfo[UserInfoField.userName]}님의 일지",
          style: const TextStyle(
            fontSize: 20,
            color: palette.cardColorWhite,
          ),
        ),
        TableCalendar(
          calendarBuilders: CustomCalendarBuilders(),
          headerStyle: CustomHeaderStyle(),
          calendarStyle: CustomCalendarStyle(),
          eventLoader: (day) {
            return _events[DateTime(day.year, day.month, day.day)] ?? [];
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _updateSelectedDayRoutines();
            });
          },
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
        ),
        FutureBuilder(
          future: routineList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Expanded(
                child: Center(
                  child: LoadingCircle(),
                ),
              );
            } else if (snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Container(
                    color: palette.bgColor,
                    child: const Text(
                      "루틴 데이터를 불러오지 못했어요.",
                      style: TextStyle(
                        color: palette.cardColorWhite,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              if (_selectedDayRoutines.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _selectedDayRoutines.length,
                    itemBuilder: (BuildContext context, int index) {
                      final routine = _selectedDayRoutines[index];

                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            routine.routineName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: palette.cardColorWhite,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ...RoutineDetail(routine.children).generateItems,
                          CancelAndEnterButtonWithIcon(
                            buttonSwap: true,
                            onCancelTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      children: [
                                        const Text(
                                          "해당 운동 기록을 삭제하시겠어요?😭",
                                          style: TextStyle(
                                            color: palette.cardColorWhite,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CancelAndEnterButtonWithIcon(
                                          onCancelTap: () {
                                            Navigator.pop(context);
                                          },
                                          cancelIcon: const Icon(null),
                                          cancelLabel: const Text(
                                            "아니요",
                                            style: TextStyle(
                                              color: palette.cardColorWhite,
                                            ),
                                          ),
                                          onEnterTap: () {
                                            setState(() {
                                              database.removeRoutine(routine);
                                            });
                                            Navigator.pop(context);
                                          },
                                          enterIcon: const TrashCanIcon(),
                                          enterLabel: const Text(
                                            "삭제",
                                            style: TextStyle(
                                              color: palette.colorRed,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            cancelIcon: const TrashCanIcon(),
                            cancelLabel: const Text(
                              "루틴 삭제",
                              style: TextStyle(
                                color: palette.cardColorWhite,
                              ),
                            ),
                            onEnterTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      children: [
                                        const Text(
                                          "해당 루틴의 내용을 수정하시겠습니까?",
                                          style: TextStyle(
                                            color: palette.cardColorWhite,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CancelAndEnterButton(
                                          onCancelTap: () {
                                            Navigator.pop(context);
                                          },
                                          onEnterTap: () {
                                            updateRoutine(
                                                context: context,
                                                database: database,
                                                routine: routine,
                                                routineProvider:
                                                    routineProvider,
                                                workoutList: RoutineDetail(
                                                        routine.children)
                                                    .getWorkoutList);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            enterIcon: const LineIcon(
                              LineIcons.pen,
                              color: palette.cardColorYelGreen,
                            ),
                            enterLabel: const Text(
                              "루틴 수정",
                              style: TextStyle(
                                color: palette.cardColorWhite,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const Expanded(
                  child: Center(
                    child: Text(
                      "운동 기록이 없어요🤔",
                      style: TextStyle(
                        fontSize: 17,
                        color: palette.cardColorWhite,
                      ),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
