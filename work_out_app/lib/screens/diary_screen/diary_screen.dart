import 'package:flutter/material.dart';
import 'package:sqlite3/sqlite3.dart';
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

  @override
  void initState() {
    super.initState();
    userInfo = context.read<provider.MainStoreProvider>().getUserInfo();
    routineList = database.getRoutines();
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
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                _focusedDay.toString(),
                style: const TextStyle(
                  color: palette.cardColorWhite,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
