import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int twentyFiveMin = 1500;
  int totalTime = twentyFiveMin;
  int totalPomodoros = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalTime == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalTime = twentyFiveMin;
      });
      timer.cancel();
    } else {
      setState(() {
        totalTime = totalTime - 1;
      });
    }
  }

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPausePressd() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String timeFormat(int seconds) {
    String duration = Duration(seconds: seconds).toString();
    return duration.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                timeFormat(totalTime),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 90,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      icon: Icon(isRunning
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_filled_rounded),
                      onPressed: isRunning ? onPausePressd : onStartPressed,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    IconButton(
                      iconSize: 60,
                      color: Theme.of(context).cardColor,
                      icon: const Icon(Icons.stop_circle_outlined),
                      onPressed: isRunning ? onPausePressd : onStartPressed,
                    ),
                  ],
                ),
              )),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoros',
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        '$totalPomodoros',
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontSize: 60,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
