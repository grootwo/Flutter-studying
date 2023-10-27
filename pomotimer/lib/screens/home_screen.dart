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
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Working',
              style: TextStyle(
                fontSize: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
