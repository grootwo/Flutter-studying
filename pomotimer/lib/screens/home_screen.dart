import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isWorking = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              isWorking ? 'Working' : 'Resting',
              style: const TextStyle(
                fontSize: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
