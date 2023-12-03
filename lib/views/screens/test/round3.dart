import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/measure/bpm_measure.dart';

import 'package:frontend/views/widgets/typetest/type_test.dart';
import 'package:get/get.dart';

import '../../widgets/Round2_quiz/round_2_quiz.dart';
import '../../widgets/Round2_result/round_2_result.dart';
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
  late PageController _pageController;
  late AnimationController _controller;
  late int _currentPage = 0;
  late Timer _timer;
  int page_count = 7;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..forward();
    startAutoScroll();
  }

  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
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
          (index <= 5) ? BpmMeasure() : Container()
        ],
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
      return round3_7(); // Return an empty container if the index is not handled
    }
  }

  Widget round3_1() {
    return const Text(
      'Welcome to Round 3, The Round is divided into alternate rests and tests sessions',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    );
  }

  Widget round3_2() {
    return QuizWidget(onDataPassed: (val) {
      quiz1 = val;
    });
  }

  Widget round3_3() {
    return const Text(
      'For Round 3.3, Take Some Rest',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    );
  }

  Widget round3_4() {
    return TypeTestWidget(
      level: "3.4",
      onDataPassed: (data1, data2) {},
    );
  }

  Widget round3_5() {
    return const Text(
      'For Round 3.5, Take Some Rest',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    );
  }

  Widget round3_6() {
    return QuizWidget(onDataPassed: (val) {
      quiz2 = val;
    });
  }

  Widget round3_7() {
    return Round3Screen(
        averageBPM: 0,
        typingSpeed: wpm ?? 0,
        accuracy: efficiency ?? 0,
        quiz1: quiz1 ?? 0,
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