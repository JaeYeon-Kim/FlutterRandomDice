import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';

class HomeScreen extends StatelessWidget {
  // 보여줄 숫자 지정
  final int number;

  const HomeScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 주사위
        Center(
          child: Image.asset('asset/img/$number.png'),
        ),
        SizedBox(
          height: 32.0,
        ),
        Text(
          '행운의 숫자',
          style: TextStyle(
              color: secondaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          number.toString(),
          style: TextStyle(
            color: primaryColor,
            fontSize: 60.0,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
