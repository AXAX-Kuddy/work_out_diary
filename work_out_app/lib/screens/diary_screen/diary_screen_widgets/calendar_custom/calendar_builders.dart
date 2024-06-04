import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class CustomCalendarBuilders extends CalendarBuilders {
  @override
  DayBuilder? get dowBuilder => (BuildContext context, DateTime day) {
        Color weekendColor(int weekday) {
          if (weekday == 6) {
            return palette.colorBlue;
          } else if (weekday == 7) {
            return palette.colorRed;
          } else {
            return palette.cardColorYelGreen;
          }
        }

        const List<String> weekName = [
          "월",
          "화",
          "수",
          "목",
          "금",
          "토",
          "일",
        ];

        return Center(
          child: Text(
            weekName[day.weekday - 1],
            style: TextStyle(
              color: weekendColor(day.weekday),
            ),
          ),
        );
      };

  @override
  DayBuilder? get headerTitleBuilder => (context, day) {
        const List<String> month = [
          '1월',
          '2월',
          '3월',
          '4월',
          '5월',
          '6월',
          '7월',
          '8월',
          '9월',
          '10월',
          '11월',
          '12월'
        ];
        return Center(
          child: Text(
            month[day.month - 1],
            style: const TextStyle(
              color: palette.cardColorWhite,
              fontSize: 17,
            ),
          ),
        );
      };
}
