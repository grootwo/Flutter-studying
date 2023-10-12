import 'package:flutter/material.dart';
import 'package:toonlinkers/models/webtoon_model.dart';
import 'package:toonlinkers/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late Future<List<WebtoonModel>> webtoons = ApiService.getTodayWebtoons();

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
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text('Here are webtoons!');
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }
}
