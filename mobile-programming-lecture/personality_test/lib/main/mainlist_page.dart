import 'package:flutter/material.dart';
import 'dart:convert';
import '../sub/question_page.dart'; // 교재 p.92
import 'package:firebase_analytics/firebase_analytics.dart'; // 교재 p.97
import 'package:firebase_remote_config/firebase_remote_config.dart'; // 교재 p.102 (2)
import 'package:firebase_database/firebase_database.dart'; // p.109 (1)

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  String welcomeTitle = '';
  bool bannerUse = false;
  int itemHeight = 50;

  // p.111 (3)
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference testRef;
  late List<String> testList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _remoteConfigInit();
    // p.111 (4)
    testRef = database.ref('test');
  }

  Future<void> _remoteConfigInit() async {
    await remoteConfig.fetch();
    await remoteConfig.activate();
    setState(() {
      welcomeTitle = remoteConfig.getString('welcome');
      bannerUse = remoteConfig.getBool('banner');
      itemHeight = remoteConfig.getInt('item_height');
    });
  }

  // p.112 (5)
  Future<List<String>> loadAsset() async {
    try {
      final snapshot = await testRef.get();
      testList.clear();
      snapshot.children.forEach((element) {
        testList.add(element.value as String);
      });
      return testList;
    } catch (e) {
      print('Failed to load data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bannerUse
          ? AppBar(
        title: Text(remoteConfig.getString('welcome')),
      )
          : null,

      // p.113 (6)
      body: FutureBuilder<List<String>>(
        future: loadAsset(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Data'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> item =
              jsonDecode(snapshot.data![index]); // JSON 문자열 → Map

              return InkWell(
                child: SizedBox(
                  height: remoteConfig.getInt('item_height').toDouble(),
                  child: Card(
                    color: Colors.amber,
                    child: Text(item['title'].toString()),
                  ),
                ),
                onTap: () async {
                  await FirebaseAnalytics.instance.logEvent(
                    name: 'test_click',
                    parameters: {'test_name': item['title'].toString()},
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return QuestionPage(question: item);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final FirebaseDatabase database = FirebaseDatabase.instance;
          final DatabaseReference testRef = database.ref('test');

          // 첫 번째 데이터
          testRef.push().set("""
          {
            "title": "당신이 좋아하는 동물은?",
            "question": "무인도에 도착한 당신이 마침 떠내려온 상자를 열어보니 보이는 물건은?",
            "selects": ["생존 키트", "휴대폰", "텐트", "책 무인도에서 살아남기"],
            "answer": [
               "당신은 현실주의 동물은 안 키웁니다",
               "당신은 늘 함께 있는 걸 좋아하는 강아지가 어울립니다",
               "당신은 같은 공간을 공유하는 고양이가 어울립니다",
               "당신은 낭만을 좋아하는 앵무새가 어울립니다"
            ]
          }
          """);

          // 두 번째 데이터
          testRef.push().set('''
          {
            "title": "5초 MBTI I/E 판별",
            "question": "친구와 함께 간 미술관 당신이라면?",
            "selects": ["말이 많아짐", "생각이 많아짐"],
            "answer": ["당신의 성향은 E", "당신의 성향은 I"]
          }
          ''');

          // 세 번째 데이터
          testRef.push().set("""
          {
            "title": "당신은 어떤 사랑을 하고 싶나요?",
            "question": "목욕을 할 때 가장 먼저 비누칠을 하는 곳은?",
            "selects": ["머리", "상체", "하체"],
            "answer": [
              "당신은 자만추를 추천해요",
              "당신은 소개팅을 통한 새로운 사람의 소개를 좋아합니다",
              "당신은 길가다가 우연히 지나친 그런 인연을 좋아합니다"
            ]
          }
          """);
        },
      ),
    );
  }
}
