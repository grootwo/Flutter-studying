import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int counter = 0;
  void onclicked() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Counter",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Text(
            "$counter",
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: onclicked,
            icon: const Icon(Icons.plus_one_rounded),
          ),
        ],
      ),
    );
  }
}
