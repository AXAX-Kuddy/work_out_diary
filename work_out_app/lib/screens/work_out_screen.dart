import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkOutScreen extends StatefulWidget {
  const WorkOutScreen({super.key});

  @override
  State<WorkOutScreen> createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void onDaySelecet(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        const Text(
          "워크아웃 페이지",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        TableCalendar(
          onDaySelected: onDaySelecet,
          selectedDayPredicate: (date) {
            return isSameDay(selectedDate, date);
          },
          focusedDay: DateTime.now(),
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
        ),
      ],
    );
  }
}
