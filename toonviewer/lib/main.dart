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
        backgroundColor: const Color(0x00fe4829),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Counter",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
              Text(
                "$counter",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
              IconButton(
                onPressed: onclicked,
                icon: const Icon(Icons.plus_one_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
