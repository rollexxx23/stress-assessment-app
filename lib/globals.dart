import 'package:flutter/material.dart';

// round 1
ValueNotifier<double> averageBPMRound1 = ValueNotifier(0.0);
ValueNotifier<double> typingSpeedRound1 = ValueNotifier(0.0);
ValueNotifier<double> accuracyRound1 = ValueNotifier(0.0);
ValueNotifier<double> voicePitchRound1 = ValueNotifier(0.0);
ValueNotifier<double> voiceVolumeRound1 = ValueNotifier(0.0);
ValueNotifier<int> currRoomId = ValueNotifier(11111);

// Round 2
ValueNotifier<double> wpm_2 = ValueNotifier(0.0);
ValueNotifier<double> efficiency_2 = ValueNotifier(0.0);
ValueNotifier<int> quiz1_2 = ValueNotifier(0);
ValueNotifier<int> quiz2_2 = ValueNotifier(0);
ValueNotifier<double> hrv_2 = ValueNotifier(0.0);
ValueNotifier<double> voicePitch_2 = ValueNotifier(0.0);
ValueNotifier<double> voiceVolume_2 = ValueNotifier(0.0);

// Round 3
ValueNotifier<double> wpm_3 = ValueNotifier(0);
ValueNotifier<double> efficiency_3 = ValueNotifier(0);
ValueNotifier<int> quiz1_3 = ValueNotifier(0);
ValueNotifier<int> quiz2_3 = ValueNotifier(0);
ValueNotifier<double> voicePitch_3 = ValueNotifier(0);
ValueNotifier<double> voiceVolume_3 = ValueNotifier(0);
ValueNotifier<double> hrv_3 = ValueNotifier(0);
