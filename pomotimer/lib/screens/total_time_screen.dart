import 'package:flutter/material.dart';

class TotalTimeScreen extends StatelessWidget {
  const TotalTimeScreen({super.key});

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
      body: const Center(
        child: Text('Hallo'),
      ),
    );
  }
}
