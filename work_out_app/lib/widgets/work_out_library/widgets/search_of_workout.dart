import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/text_field/non_form_text_field.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class SearchWorkout extends StatefulWidget {
  const SearchWorkout({super.key});

  @override
  State<SearchWorkout> createState() => _SearchWorkoutState();
}

class _SearchWorkoutState extends State<SearchWorkout> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: palette.cardColorYelGreen,
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {},
      onSubmitted: (value) {},
      style: TextStyle(
        fontSize: 18,
        color: palette.cardColorWhite,
      ),
      decoration: InputDecoration(
        focusColor: palette.cardColorYelGreen,
        prefixIcon: const LineIcon(
          LineIcons.search,
          size: 25,
        ),
        prefixIconColor: palette.cardColorYelGreen,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: palette.cardColorYelGreen,
          ),
        ),
      ),
    );
  }
}
