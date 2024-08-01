import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class PlateCalculator extends StatefulWidget {
  final double weight;
  final BoxConstraints constraints;

  const PlateCalculator({
    super.key,
    required this.weight,
    required this.constraints,
  });

  @override
  State<PlateCalculator> createState() => _PlateCalculatorState();
}

class _PlateCalculatorState extends State<PlateCalculator> {
  late double weight = widget.weight;

  List<Widget> plates = [];

  void calculate() {
    for (int i = 0; i < 10; i++) {
      plates.add(Plate.build(25));
    }
  }

  @override
  void initState() {
    if (widget.weight > 500) {
      weight = 500;
    }

    calculate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                bottom: 65,
                child: Barbell(constraints: widget.constraints),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 50,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...plates,
                  ],
                ),
              ),
            ],
          ),
          Text(widget.weight.toString()),
        ],
      ),
    );
  }
}

class Barbell extends StatelessWidget {
  final BoxConstraints constraints;

  const Barbell({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth * 0.55,
      height: 15,
      decoration: const BoxDecoration(
        color: palette.cardColorGray,
      ),
    );
  }
}

class Plate {
  static Color _selectColor(double weight) {
    switch (weight) {
      case 20:
        return palette.plate20kg;
      case 15:
        return palette.plate15kg;
      case 10:
        return palette.plate10kg;
      case 5:
        return palette.plate5kg;
      case 2.5:
        return palette.plate2n5kg;
      case 1.25:
        return palette.plate1n25kg;
      case 0.5:
        return palette.plate0n5kg;
      case 0.25:
        return palette.plate0n25kg;
      default:
        return palette.plate25kg;
    }
  }

  static double _selectWidth(double weight) {
    if (weight >= 20) {
      return 20;
    } else if (weight >= 10) {
      return 17.5;
    } else if (weight >= 5) {
      return 12.5;
    } else {
      return 9.5;
    }
  }

  static double _selectHeight(double weight) {
    if (weight >= 20) {
      return 150;
    } else if (weight >= 15) {
      return 130;
    } else if (weight >= 10) {
      return 85;
    } else if (weight >= 5) {
      return 50;
    } else {
      return 30;
    }
  }

  static Widget build(double weight) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 1.5,
      ),
      width: _selectWidth(weight),
      height: _selectHeight(weight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: _selectColor(weight),
      ),
    );
  }
}
