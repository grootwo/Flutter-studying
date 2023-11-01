import 'package:flutter/material.dart';

class TotalTimeScreen extends StatelessWidget {
  const TotalTimeScreen({
    super.key,
    required this.totalTime,
  });
  final String totalTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Total Time',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.normal,
          ),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(totalTime),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.highlight_remove),
            ),
          ],
        ),
      ),
    );
  }
}
