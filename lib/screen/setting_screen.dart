import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';

class SettingScreen extends StatelessWidget {
  // slider의 현재값
  final double threshold;

  // slider가 변경될때마다 실행되는 함수
  final ValueChanged<double> onThresholdChange;

  const SettingScreen({
    super.key,
    required this.threshold,
    required this.onThresholdChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                '민감도',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        Slider(
          min : 0.1,  // 최솟값
          max : 10.0, // 최대값
          divisions: 101,  // 최소값과 최댓값 사이의 구간 개수
          value: threshold,   // 슬라이더 선택 값
          onChanged: onThresholdChange, // 값 변경 시 실행되는 함수
          label: threshold.toStringAsFixed(1),    // 표싯값
        )
      ],
    );
  }
}
