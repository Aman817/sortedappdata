import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sortedapp/loginscreen.dart';
import 'package:sortedapp/timerStopwatchScreen.dart';

class MenuScreenActivity extends StatefulWidget {
  const MenuScreenActivity({super.key});

  @override
  State<MenuScreenActivity> createState() => _MenuScreenActivityState();
}

class _MenuScreenActivityState extends State<MenuScreenActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sorted App")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TimerStopwatchScreen()),
                    );
                  },
                  child: Text("Timer Stop Watch"))),
          SizedBox(
            height: 20,
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text("Login Screen Task 2")))
        ],
      ),
    );
  }
}
