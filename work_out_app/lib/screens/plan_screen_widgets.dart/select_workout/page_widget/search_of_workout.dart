import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/non_form_text_field.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        focusColor: palette.cardColorYelGreen,
        prefixIcon: const LineIcon(
          LineIcons.pen,
          size: 25,
        ),
        prefixIconColor: palette.cardColorYelGreen,
      ),
    );
  }
}
