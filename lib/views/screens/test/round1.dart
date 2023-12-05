import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/views/widgets/measure/bpm_measure.dart';
import 'package:frontend/views/widgets/record/record.dart';
import 'package:frontend/views/widgets/round_1_result/round1_result.dart';
import 'package:frontend/views/widgets/typetest/type_test.dart';
import 'package:get/get.dart';

class Round1 extends StatefulWidget {
  @override
  _Round1State createState() => _Round1State();
}

class _Round1State extends State<Round1> with SingleTickerProviderStateMixin {
  double? wpm = 0;
  double? efficiency = 0;
  double? voicePitch;
  double? voiceVolume;
  double hrv = 00.0;

  late PageController _pageController;
  late AnimationController _controller;
  late int _currentPage = 0;
  late Timer _timer;
  int page_count = 5;
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
                      Get.back();
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
    );
  }

  Widget getWidgetForIndex(int index) {
    if (index == 0) {
      return round1_1();
    } else if (index == 1) {
      return round1_2();
    } else if (index == 2) {
      return round1_3();
    } else if (index == 3) {
      return round1_4();
    } else if (index == 4) {
      return round1_5();
    } else {
      return Container(); // Return an empty container if the index is not handled
    }
  }

  Widget round1_1() {
    return Column(
      children: [
        const Text(
          'Welcome to Round 1, here you will be measured without any acute stress. Please Perform The Tasks As Instructed',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        BpmMeasure(
          onDataPassed: (val) {
            hrv = (hrv + val.toDouble()) / (hrv == 0 ? 1 : 2);
          },
        )
      ],
    );
  }

  Widget round1_2() {
    return Column(
      children: [
        const Text(
          'Welcome to Round 1.2, Here Your HRV as well as Facial Expression will be recoreded under stress-free condition',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        BpmMeasure(
          onDataPassed: (val) {
            hrv = (hrv + val.toDouble()) / (hrv == 0 ? 1 : 2);
          },
        )
      ],
    );
  }

  Widget round1_3() {
    return TypeTestWidget(
        level: "1.3",
        onDataPassed: (data1, data2) {
          wpm = data1;
          efficiency = data2;
        });
  }

  Widget round1_4() {
    return RecordVoiceScreen(
      onDataPassed: ((p0, p1) {
        voicePitch = p1;
        voiceVolume = p0;
      }),
    );
  }

  Widget round1_5() {
    return ResultScreen(
        averageBPM: hrv,
        typingSpeed: wpm ?? 0,
        accuracy: efficiency ?? 0,
        voicePitch: voicePitch ?? 0,
        voiceVolume: voiceVolume ?? 0);
  }
}
