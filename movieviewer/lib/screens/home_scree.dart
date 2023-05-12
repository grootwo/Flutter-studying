import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const [
          Text(
            'Popular Movie',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
