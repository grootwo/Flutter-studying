import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pomotimer/screens/total_time_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int setTime = 1500;
  int leftTime = 10;
  int totalTime = 0;
  late Timer timer;
  bool isTick = false;
  bool isWorking = true;

  void onStartPressed() {
    setState(() {
      isTick = true;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isTick = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isTick = false;
      leftTime = setTime;
    });
  }

  void onTick(Timer timer) {
    if (leftTime == 0) {
      totalTime += setTime;
      timer.cancel();
      setState(() {
        leftTime = setTime;
        isTick = false;
      });
    } else {
      setState(() {
        leftTime -= 1;
      });
    }
  }

  String getTimeFormat(int sec) {
    return Duration(seconds: sec).toString().substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                isWorking ? 'Working' : 'Resting',
                style: const TextStyle(
                  fontSize: 45,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(
                              0,
                              5,
                            ),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        getTimeFormat(leftTime),
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(
                              0,
                              5,
                            ),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: isTick ? onPausePressed : onStartPressed,
                        icon: Icon(
                          isTick
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(
                              0,
                              5,
                            ),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: onResetPressed,
                        icon: const Icon(
                          Icons.square_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TotalTimeScreen(
                      totalTime: getTimeFormat(totalTime),
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, -1),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsetsDirectional.only(top: 30),
                  child: Text(
                    "Total Time",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
