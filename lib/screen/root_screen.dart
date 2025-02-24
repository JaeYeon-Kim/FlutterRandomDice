import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/setting_screen.dart';
import 'package:shake/shake.dart';

/*
* Tab Bar View는 TabController가 필수적
* Tab Conroller를 초기화하려면 vsync 기능이 필요한데 이는 state 위젯에 TickerProviderMixin을 제공 해줘야함
* */
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  // 상태 생성
  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

// TickerProviderStateMixin: 애니메이션의 효율을 올려주는 역할
// 정확히 한 틱(1FPS) 마다 애니메이션을 실행
class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7; // 민감도의 기본값 설정
  int number = 1; // 주사위 숫자
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();
    controller = TabController(
        length: 2,
        vsync:
            this); // 탭 개수와 현재 TickerProviderStateMixin을 사용하는 클래스를 할당, 컨트롤러 초기화 하기

    // 컨트롤러 속성이 변경될때마다 실행할 함수 등록
    controller!.addListener(tabListener);

    // 흔들기 감지 즉시 시작
    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100, // 감지 주기
      shakeThresholdGravity: threshold,   // 감지 민감도
      onPhoneShake: onPhoneShake, // 흔들기 감지 후 실행할 함수
    );
  }

  void onPhoneShake() {   // 흔들기 감지후 실행할 함수
    final rand = Random();

    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener() {
    // 리스너로 사용할 함수
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener); // 리스너에 등록한 함수 등록 취소
    shakeDetector!.stopListening();     // 흔들기 감지 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),

      // 아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      // 주사위 화면
      HomeScreen(number: number),
      // 설정 화면
      SettingScreen(threshold: threshold, onThresholdChange: onThresholdChange)
    ];
  }

  // 슬라이더값 변경시 실행 함수
  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    // 탭 네비게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 현재 화면에 렌더링 되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index) {
        // 탭이 선택될때마다 실행
        setState(() {
          controller!.animateTo(index);
        });
      },

      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.edgesensor_high_outlined,
            ),
            label: '주사위'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        )
      ],
    );
  }
}
