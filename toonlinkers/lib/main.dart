import 'package:flutter/material.dart';
import 'package:toonlinkers/screens/home_screen_for_webtoon.dart';
import 'package:toonlinkers/services/api_service.dart';

void main() {
  ApiService().getTodayWebtoons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
