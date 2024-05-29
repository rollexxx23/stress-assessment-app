import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:wakelock/wakelock.dart';
import '../chart.dart';

class BpmMeasure extends StatefulWidget {
  int round;
  BpmMeasure({super.key, required this.round});
  @override
  BpmMeasureView createState() {
    return BpmMeasureView();
  }
}

class BpmMeasureView extends State<BpmMeasure>
    with SingleTickerProviderStateMixin {
  bool _toggled = false;
  final List<SensorValue> _data = <SensorValue>[];
  CameraController? _controller;
  final double _alpha = 0.3;
  AnimationController? _animationController;
  double _bpm = 0;
  final int _fs = 30;
  final int _windowLen = 30 * 6;
  CameraImage? _image;
  double? _avg;
  DateTime? _now;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animationController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    _toggled = false;
    _disposeController();
    Wakelock.disable();
    _animationController!.stop();
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        IconButton(
          icon: Icon(_toggled ? Icons.favorite : Icons.favorite_border),
          color: Colors.red,
          iconSize: 128,
          onPressed: () {
            if (_toggled) {
              _untoggle();
            } else {
              _toggle();
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      _controller != null && _toggled
                          ? AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: CameraPreview(_controller!),
                            )
                          : Container(
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              color: Colors.grey,
                            ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          _toggled
                              ? "Cover both the camera and the flash with your finger"
                              : "Camera feed will display here",
                          style: TextStyle(
                              backgroundColor:
                                  _toggled ? Colors.white : Colors.transparent),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Estimated BPM",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  (_bpm > 30 && _bpm < 150 ? _bpm.toStringAsFixed(2) : "--"),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            )),
          ],
        ),
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Colors.black),
          child: Chart(_data),
        ),
      ],
    );
  }

  void _clearData() {
    // create array of 128 ~= 255/2
    _data.clear();
    int now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < _windowLen; i++) {
      _data.insert(
          0,
          SensorValue(
              DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 128));
    }
  }

  void _toggle() {
    _clearData();
    _initController().then((onValue) {
      Wakelock.enable();
      _animationController!.repeat(reverse: true);
      setState(() {
        _toggled = true;
      });
      // after is toggled
      _initTimer();
      _updateBPM();
    });
  }

  void _untoggle() {
    _disposeController();
    Wakelock.disable();
    _animationController!.stop();
    _animationController!.value = 0.0;
    setState(() {
      _toggled = false;
    });
  }

  void _disposeController() {
    _controller?.dispose();
    _controller = null;
  }

  Future<void> _initController() async {
    try {
      List cameras = await availableCameras();
      _controller = CameraController(cameras.first, ResolutionPreset.low);
      await _controller!.initialize();
      Future.delayed(const Duration(milliseconds: 100)).then((onValue) {
        _controller!.setFlashMode(FlashMode.torch);
      });
      _controller!.startImageStream((CameraImage image) {
        _image = image;
      });
    } on Exception {
      //debugPrint(Exception);
    }
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
      if (_toggled) {
        if (_image != null) _scanImage(_image!);
      } else {
        timer.cancel();
      }
    });
  }

  void _scanImage(CameraImage image) {
    _now = DateTime.now();
    _avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    if (_data.length >= _windowLen) {
      _data.removeAt(0);
    }
    setState(() {
      _data.add(SensorValue(_now!, 255 - _avg!));
    });
  }

  void _updateBPM() async {
    List<SensorValue> values;
    double avg;
    int n;
    double m;
    double threshold;
    int counter;
    int previous;
    while (_toggled) {
      values = List.from(_data);
      avg = 0;
      n = values.length;
      m = 0;
      for (var value in values) {
        avg += value.value / n;
        if (value.value > m) m = value.value;
      }
      threshold = (m + avg) / 2;
      _bpm = 0;
      counter = 0;
      previous = 0;
      for (int i = 1; i < n; i++) {
        if (values[i - 1].value < threshold && values[i].value > threshold) {
          if (previous != 0) {
            counter++;
            _bpm += 60000 / (values[i].time.millisecondsSinceEpoch - previous);
          }
          previous = values[i].time.millisecondsSinceEpoch;
        }
      }
      if (counter > 0) {
        _bpm = _bpm / counter;
        setState(() {
          _bpm = (1 - _alpha) * _bpm + _alpha * _bpm;
        });
        if (widget.round == 1) {
          averageBPMRound1.value += _bpm;
          averageBPMRound1.value /= 2;
        } else if (widget.round == 2) {
          hrv_2.value += _bpm;
          hrv_2.value /= 2;
        } else {
          hrv_3.value += _bpm;
          hrv_3.value /= 2;
        }
      }
      await Future.delayed(Duration(milliseconds: (1000 * 50 / 30).round()));
    }
  }
}
