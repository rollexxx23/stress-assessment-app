import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/measure/bpm_measure.dart';
import 'package:frontend/views/widgets/record/record.dart';

import 'package:frontend/views/widgets/typetest/type_test.dart';
import 'package:get/get.dart';

import '../../widgets/Round2_quiz/round_2_quiz.dart';
import '../../widgets/round3_result/round_3_result.dart';
import '../home_screen.dart';

class Round3 extends StatefulWidget {
  @override
  _Round3State createState() => _Round3State();
}

class _Round3State extends State<Round3> with SingleTickerProviderStateMixin {
  double? wpm = 0;
  double? efficiency = 0;
  int? quiz1 = 0;
  int? quiz2 = 0;
  double? voicePitch = 0;
  double? voiceVolume = 0;
  double hrv = 0.0;
  late PageController _pageController;
  late AnimationController _controller;
  late int _currentPage = 0;
  late Timer _timer;
  int page_count = 6;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..forward();
    startAutoScroll();
  }

  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_currentPage < 3 - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          itemCount: page_count,
          itemBuilder: (context, index) {
            return buildRoundPage(index);
          },
        ),
      ),
    );
  }

  Widget buildRoundPage(int index) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.offAll(const HomeScreen());
                      },
                      child: const Icon(Icons.arrow_back_ios))
                ],
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _controller.value,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                );
              },
            ),
            const SizedBox(height: 20.0),
            getWidgetForIndex(index),
          ],
        ),
      ),
    );
  }

  Widget getWidgetForIndex(int index) {
    if (index == 0) {
      return round3_1();
    } else if (index == 1) {
      return round3_2();
    } else if (index == 2) {
      return round3_3();
    } else if (index == 3) {
      return round3_4();
    } else if (index == 4) {
      return round3_5();
    } else if (index == 5) {
      return round3_6();
    } else {
      return Container(); // Return an empty container if the index is not handled
    }
  }

  Widget round3_1() {
    return Column(
      children: const [
        Text(
          'Welcome to Round 3, The Round is divided into alternate rests and tests sessions',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        BpmMeasure()
      ],
    );
  }

  Widget round3_2() {
    return Column(
      children: [
        QuizWidget(onDataPassed: (val) {
          quiz1 = val;
        }),
        const BpmMeasure()
      ],
    );
  }

  Widget round3_3() {
    return TypeTestWidget(
      level: "3.3",
    );
  }

  Widget round3_4() {
    return Column(
      children: [
        QuizWidget(onDataPassed: (val) {
          quiz2 = val;
        }),
        const BpmMeasure()
      ],
    );
  }

  Widget round3_5() {
    return RecordVoiceScreen(
      round: "3.5",
    );
  }

  Widget round3_6() {
    return Round3Screen(
        averageBPM: hrv,
        typingSpeed: wpm ?? 0,
        accuracy: efficiency ?? 0,
        quiz1: quiz1 ?? 0,
        volume: voiceVolume ?? 0,
        quiz2: quiz2 ?? 0);
  }
}


//rest
//quiz
//rest - 10 sec
//typing
//rest - 10 sec
//quiz 
//rest - 10 sec
//voice