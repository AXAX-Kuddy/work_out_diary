// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_out_app/database/database.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/calendar_custom/calendar_builders.dart';
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/calendar_custom/calendar_style.dart';
import 'package:work_out_app/screens/home_screen/home_screen.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/header_style.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/store.dart' as provider;

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final AppDatabase database = AppDatabase();
  late Future<List<Routine>> routineList;
  late provider.UserInfo userInfo;

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
        if (_selectedDayRoutines.isNotEmpty)
          Expanded(
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
                  ],
                );
              },
            ),
          )
        else
          const Expanded(
            child: Center(
              child: Text(
                "운동 기록이 없어요😢",
                style: TextStyle(
                  color: palette.cardColorWhite,
                ),
              ),
            ),
          )
      ],
    );
  }
}

class RoutineDetail {
  List<maked.Workout> workoutList = [];

  void routineChildrenDecode(String children) {
    dynamic decodeJson = jsonDecode(children);
    debugPrint("$decodeJson");

    try {
      if (decodeJson is List<dynamic>) {
        for (var workout in decodeJson) {
          maked.Workout instance =
              maked.Workout.toJsonDecode(jsonDecode(workout));
          workoutList.add(instance);
        }
      } else if (decodeJson is Map<String, dynamic>) {
        final maked.Workout instance = maked.Workout.toJsonDecode(decodeJson);
        workoutList.add(instance);
      } else {
        throw TypeError();
      }
    } catch (event) {
      print(event);
    }
  }

  List<Widget> builder() {
    return const [Text("")];
  }
}
