import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/text_field/non_form_text_field.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/widgets/work_out_library/work_out_library.dart';
import 'package:work_out_app/provider/store.dart' as provider;

class SearchWorkout extends StatefulWidget {
  final void Function() handleChangedPart;
  final void Function(String) changedSearchText;
  final List<provider.WorkoutMenu> allWorkoutList;

  const SearchWorkout({
    super.key,
    required this.handleChangedPart,
    required this.allWorkoutList,
    required this.changedSearchText,
  });

  @override
  State<SearchWorkout> createState() => _SearchWorkoutState();
}

class _SearchWorkoutState extends State<SearchWorkout> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        return;
      } else {
        if (_controller.text.isEmpty) {
          setState(() {
            ChangePart.changeIndex(0);
            widget.handleChangedPart();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: palette.cardColorYelGreen,
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {
        setState(() {
          ChangePart.changeIndex(6);
          widget.handleChangedPart();
          widget.changedSearchText(value);
        });
      },
      onSubmitted: (value) {},
      style: const TextStyle(
        fontSize: 18,
        color: palette.cardColorWhite,
      ),
      decoration: const InputDecoration(
        focusColor: palette.cardColorYelGreen,
        prefixIcon: LineIcon(
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
