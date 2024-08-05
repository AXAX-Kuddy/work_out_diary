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
  /// 최초 제시된 무게
  late double weight;

  /// 조정된 무게(플레이트로 계산이 불가능할 경우)
  late double adjustedWeight;

  /// 최초 제시된 무게와 조정된 무게와의 차이
  late double weightDifference;

  /// 렌더링 될 플레이트들
  List<Widget> plates = [];

  /// 플레이트 종류와 가짓수 체크
  Map<double, int> plateCountsMap = {};

  /// 사용할 플레이트 무게
  final List<double> plateWeights = [20, 15, 10, 5, 2.5, 1.25, 0.5, 0.25];

  /// 초기 플레이트 갯수
  final Map<double, int> initialPlateCounts = {
    25: 10,
    20: 10,
    15: 10,
    10: 10,
    5: 10,
    2.5: 10,
    1.25: 10,
    0.5: 10,
    0.25: 10,
  };

  /// 실제 플레이트 갯수
  late Map<double, int> plateCounts;

  /// 원판 무게 계산기
  ///
  /// 지금까지 한 것 중에서 제일 만들기 까다로웠다 ㄹㅇ
  void calculate(double totalWeight) {
    /// 리스트 초기화
    plates.clear();

    /// 플레이트 종류와 가짓수 초기화
    plateCountsMap.clear();

    /// 무게가 최소 20 이상이여야함
    double remainingWeight = totalWeight - 20;
    if (remainingWeight < 0) {
      return;
    }

    /// 최소 플레이트 한쌍
    double minPlateWeight = plateWeights.last * 2;

    /// 최대 플레이트 한쌍
    double maxPlateWeight = plateWeights.first * 2;

    if (remainingWeight % minPlateWeight != 0) {
      /// 하한(내림)
      double lowerBound = (remainingWeight ~/ minPlateWeight) * minPlateWeight;

      /// 상한(올림)
      double upperBound = lowerBound + minPlateWeight;

      /// 하한과 상한 중 근사값
      if (remainingWeight - lowerBound <= upperBound - remainingWeight) {
        remainingWeight = lowerBound;
      } else {
        remainingWeight = upperBound;
      }
    }

    /// 조정된 무게
    adjustedWeight = remainingWeight + 20;

    /// 최초 제시된 값과 조정된 값의 차이
    weightDifference = (adjustedWeight - totalWeight).abs();

    for (var weight in plateWeights) {
      /// 총 사용된 플레이트 갯수
      int count = 0;

      /// remainingWeight >= weight * 2  <- 최소 한쌍의 플레이트를 추가할 수 있는지 체크
      /// plateCounts[weight]! > 0 <- 현재 무게의 플레이트가 남아 있는지 체크
      while (remainingWeight >= weight * 2 && plateCounts[weight]! > 0) {
        /// 남은 무게에서 추가된 플레이트 무게 한쌍을 뺌
        remainingWeight -= weight * 2;

        /// 현재 남은 플레이트 갯수에서 사용된 플레이트를 하나 뺌
        plateCounts[weight] = plateCounts[weight]! - 1;

        /// 총 사용된 플레이트 갯수를 2개 증가시킴(양 쪽에 하나씩)
        count += 2;
      }

      /// 플레이트가 최소 하나 이상 사용 됐을 경우
      if (count > 0) {
        /// 사용된 플레이트 갯수의 절반 만큼 반복(위젯 상으론 바벨의 한쪽만 표시할 것이므로)
        for (int i = 0; i < count / 2; i++) {
          plateCountsMap[weight] = count ~/ 2;

          /// 해당되는 플레이트를 plates 리스트에 추가함
          plates.add(Plate.build(weight));
        }
      }
    }

    /// 계산을 마친 뒤, 위젯 업데이트
    setState(() {});
  }

  @override
  void initState() {
    weight = widget.weight;

    /// 최대 무게 500kg으로 제한(위젯에 표시할 수 있는 한계)
    if (widget.weight > 500) {
      weight = 500;
    }

    ///사용 가능한 플레이트 갯수 초기화
    plateCounts = Map.from(initialPlateCounts);
    calculate(weight);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PlateCalculator oldWidget) {
    ///매개변수로 받은 무게가 바뀌었을 경우
    if (widget.weight != oldWidget.weight) {
      weight = widget.weight;

      ///사용 가능한 플레이트 갯수 초기화
      plateCounts = Map.from(initialPlateCounts);

      /// 바뀐 무게에 맞춰 다시 계산
      calculate(weight);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    if (plateWeights.contains(25)) {
                      plateWeights.remove(25);
                      plateCounts = Map.from(initialPlateCounts);
                      calculate(weight);
                    }
                  },
                  child: const Text(
                    "20Kg",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: palette.cardColorWhite,
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 7,
                  thickness: 1,
                  color: palette.cardColorGray,
                ),
                TextButton(
                  onPressed: () {
                    if (!plateWeights.contains(25)) {
                      plateWeights.insert(0, 25);
                      plateCounts = Map.from(initialPlateCounts);
                      calculate(weight);
                    }
                  },
                  child: const Text(
                    "25Kg",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: palette.colorRed,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
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
          const SizedBox(
            height: 20,
          ),
          ...plateCountsMap.entries.map((plate) {
            return Row(
              children: [
                Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    color: Plate.selectColor(plate.key),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${plate.key}kg: ",
                  style: const TextStyle(
                    fontSize: 20,
                    color: palette.cardColorWhite,
                  ),
                ),
                Text(
                  "${plate.value}장",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: palette.cardColorWhite,
                  ),
                ),
              ],
            );
          }).toList(),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              const Text(
                "현재 무게: ",
                style: TextStyle(
                  fontSize: 16,
                  color: palette.cardColorWhite,
                ),
              ),
              Text(
                "${widget.weight} kg",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: palette.colorBlue,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                "조정되어 계산된 무게: ",
                style: TextStyle(
                  fontSize: 16,
                  color: palette.cardColorWhite,
                ),
              ),
              Text(
                "${adjustedWeight.toStringAsFixed(2)} kg",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: palette.cardColorYelGreen,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                "본 무게와의 조정 오차: ",
                style: TextStyle(
                  fontSize: 16,
                  color: palette.cardColorWhite,
                ),
              ),
              Text(
                "${weightDifference.toStringAsFixed(2)} kg",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: palette.colorRed,
                ),
              ),
            ],
          ),
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
  static Color selectColor(double weight) {
    switch (weight) {
      case 25:
        return palette.plate25kg;
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

  static double selectWidth(double weight) {
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

  static double selectHeight(double weight) {
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
      width: selectWidth(weight),
      height: selectHeight(weight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: selectColor(weight),
      ),
    );
  }
}
