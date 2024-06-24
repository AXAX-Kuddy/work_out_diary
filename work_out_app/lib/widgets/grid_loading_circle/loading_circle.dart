import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: palette.cardColorYelGreen,
    );
  }
}
