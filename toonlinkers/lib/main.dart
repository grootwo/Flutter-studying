import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<int> nums = [];
  int count = 0;

  void onClicked() {
    setState(() {
      count = count + 1;
      nums.add(count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click Count',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              for (var num in nums)
                Text(
                  '$num',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              IconButton(
                iconSize: 70,
                onPressed: onClicked,
                icon: const Icon(
                  Icons.add_box,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
