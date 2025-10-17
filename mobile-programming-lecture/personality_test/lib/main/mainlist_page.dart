// 이 파일은 앱의 첫 화면으로, JSON 데이터를 불러와 목록 형태로 표시합니다.
// ‘비동기 데이터 처리’와 ‘화면 전환(Navigator)’의 기본 흐름을 설명하는 파트입니다.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../sub/question_page.dart'; // [p.92] QuestionPage로 화면 이동을 위한 import
import 'package:firebase_analytics/firebase_analytics.dart'; // [p.97] 클릭 이벤트 로그 전송용 Firebase Analytics
import 'package:firebase_remote_config/firebase_remote_config.dart';

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
    );
  }
}
