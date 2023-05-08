import 'package:flutter/material.dart';
import 'package:toonviewer/API/api_service.dart';
import 'package:toonviewer/screens/home_screen_for_toonviewer.dart';

void main() {
  ApiService().getTodayToons();
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
