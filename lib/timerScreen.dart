// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TimerScreenActivity extends StatefulWidget {
  const TimerScreenActivity({super.key});

  @override
  State<TimerScreenActivity> createState() => _TimerScreenActivityState();
}

class _TimerScreenActivityState extends State<TimerScreenActivity> {
  TextEditingController _controller = TextEditingController();
  late Timer _timer;
  Duration _timerDuration = Duration.zero;
  String _formattedTime = '';

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _timerDuration = Duration(minutes: int.parse(_controller.text));
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            if (_timerDuration.inSeconds <= 0) {
              _timer.cancel();
              _showPopup();
            } else {
              _timerDuration = _timerDuration - Duration(seconds: 1);
              _formattedTime = _getFormattedTime();
            }
          });
        });
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Timer Completed'),
          content: Text('The timer has reached 00:00:00.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getFormattedTime() {
    int minutes = _timerDuration.inMinutes % 60;
    int seconds = _timerDuration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Set timer in minutes',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: _startTimer,
      ),
    );
  }
}
