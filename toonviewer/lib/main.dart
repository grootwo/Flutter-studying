import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _ApptState();
}

class _ApptState extends State<App> {
  int counter = 0;
  void onclicked() {
    setState(() {
      counter = counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Counter",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
              Text(
                "$counter",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
              IconButton(
                onPressed: onclicked,
                iconSize: 50,
                color: Colors.yellow,
                icon: const Icon(
                  Icons.plus_one_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
