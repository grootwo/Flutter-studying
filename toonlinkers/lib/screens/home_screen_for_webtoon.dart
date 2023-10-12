import 'package:flutter/material.dart';
import 'package:toonlinkers/models/webtoon_model.dart';
import 'package:toonlinkers/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebtoons() async {
    webtoons = await ApiService.getTodayWebtoons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebtoons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Today\'s webtoons',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
