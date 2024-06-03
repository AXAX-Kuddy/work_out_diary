import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/calendar_custom/calendar_builders.dart';
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/calendar_custom/calendar_style.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/diary_screen/diary_screen_widgets/header_style.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        const Text(
          "기록",
          style: TextStyle(
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
