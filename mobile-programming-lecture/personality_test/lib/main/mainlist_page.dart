// 이 파일은 앱의 첫 화면으로, JSON 데이터를 불러와 목록 형태로 표시합니다.
// ‘비동기 데이터 처리’와 ‘화면 전환(Navigator)’의 기본 흐름을 설명하는 파트입니다.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../sub/question_page.dart'; // [p.92] QuestionPage로 화면 이동을 위한 import
import 'package:firebase_analytics/firebase_analytics.dart'; // [p.97] 클릭 이벤트 로그 전송용 Firebase Analytics
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_database/firebase_database.dart';

// [p.83] StatefulWidget: 상태 변화가 발생하는 동적 화면 구성 시 사용
// MainPage는 JSON을 로드한 뒤 화면이 업데이트되므로 StatefulWidget이 적합합니다.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

// [p.84] _MainPage 상태 클래스: 실제 UI와 로직이 구현되는 곳
// build() 메서드와 FutureBuilder.
class _MainPage extends State<MainPage> {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  String welcomeTitle = '';
  bool bannerUse = false;
  int itemHeight = 50;

  @override
  void initState() {
    super.initState();
    remoteConfigInit(); // p.102 (3)
  }

  // p.102 (3)
  Future<void> remoteConfigInit() async {
    await remoteConfig.fetch();
    await remoteConfig.activate();
    setState(() {
      welcomeTitle = remoteConfig.getString('welcome');
      bannerUse = remoteConfig.getBool('banner');
      itemHeight = remoteConfig.getInt('item_height');
    });
  }

  // [p.84] 비동기 JSON 파일 로드 함수
  // assets 폴더(res/api/list.json)에 저장된 테스트 목록 데이터를 불러옵니다.
  // rootBundle은 Flutter의 내장 리소스 접근 도구입니다.
  Future<String> loadAsset() async {
    return await rootBundle.loadString('res/api/list.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // p.103 (4)
      appBar: bannerUse
          ? AppBar(
        title: Text(remoteConfig.getString('welcome')), // ← 책 그대로
      )
          : null,
      body: FutureBuilder<String>(
        future: loadAsset(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.hasData) {
                Map<String, dynamic> list = jsonDecode(snapshot.data!);

                return ListView.builder(
                  itemCount: list['count'],
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        try {
                          await FirebaseAnalytics.instance.logEvent(
                            name: 'test_click',
                            parameters: {
                              'test_name':
                              list['questions'][index]['title'].toString(),
                            },
                          );

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return QuestionPage(
                                  question: list['questions'][index]['file']
                                      .toString(),
                                );
                              },
                            ),
                          );
                        } catch (e) {
                          print('Failed to log event: $e');
                        }
                      },
                      child: SizedBox(
                        height: itemHeight.toDouble(), // p.103 (4)
                        child: Card(
                          child: Text(
                            list['questions'][index]['title'].toString(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: Text('No Data'));
              }

            default:
              return const Center(child: Text('No Data'));
          }
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
