import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _formattedTime = _getFormattedTime();
      });
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  String _getFormattedTime() {
    int milliseconds = _stopwatch.elapsed.inMilliseconds % 1000;
    int seconds = _stopwatch.elapsed.inSeconds % 60;
    int minutes = _stopwatch.elapsed.inMinutes % 60;
    int hours = _stopwatch.elapsed.inHours;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${(milliseconds / 10).floor().toString().padLeft(2, '0')}';
  }

  void _startStopwatch() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _formattedTime = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formattedTime,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Icon(_stopwatch.isRunning ? Icons.stop : Icons.play_arrow),
            onPressed: _startStopwatch,
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: _resetStopwatch,
          ),
        ],
      ),
    );
  }
}
