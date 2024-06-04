import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class CustomCalendarStyle extends CalendarStyle {
  @override
  bool get outsideDaysVisible => false;

  @override
  TextStyle get weekendTextStyle => const TextStyle(
        color: palette.cardColorWhite,
      );

  @override
  TextStyle get defaultTextStyle => const TextStyle(
        color: palette.cardColorWhite,
      );

  @override
  Decoration get todayDecoration => BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.5,
          color: palette.cardColorGray,
        ),
        color: palette.bgColor,
      );

  @override
  Decoration get selectedDecoration => BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.5,
          color: palette.cardColorYelGreen,
        ),
        color: palette.bgColor,
      );
}
