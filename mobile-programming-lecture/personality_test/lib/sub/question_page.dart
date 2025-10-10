// mainlist_page.dart에서 선택한 테스트 파일을 받아와, 문항을 출력하고 선택 결과를 detail_page로 전달합니다.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart'; // [p.98] Firebase 분석 이벤트 추가
import '../detail/detail_page.dart';
class QuestionPage extends StatefulWidget {
  final String question; //전달받은 질문 파일명
  const QuestionPage({super.key, required this.question});
  @override
  State<QuestionPage> createState() => _QuestionPage();
}
class _QuestionPage extends State<QuestionPage> {
  String title = '';
  int selectNumber = -1;
// assets 폴더의 JSON 파일 로드 (비동기)
// rootBundle을 사용하여 Flutter 앱 내부 리소스를 읽어옵니다.
  Future<String> loadAsset(String fileName) async {
    return await rootBundle.loadString('res/api/$fileName.json');
  }
  @override
  Widget build(BuildContext context) {
// [p.92] FutureBuilder: 비동기 데이터의 상태에 따라 UI를 분기 처리
    return FutureBuilder(
      future: loadAsset(widget.question),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
//데이터 로딩 중인 경우 로딩 인디케이터 표시
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
//데이터 로드 완료 후 JSON 파싱
          Map<String, dynamic> questions = jsonDecode(snapshot.data!);
          title = questions['title'].toString();
// 선택지(라디오 버튼) 생성
          List<Widget> widgets = List<Widget>.generate(
            (questions['selects'] as List<dynamic>).length,
                (int index) =>
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
// 선택지 텍스트 표시
                      Text(questions['selects'][index]),
// [p.94] Radio 위젯으로 선택 기능 구현
                      Radio(
                        value: index,
                        groupValue: selectNumber,
                        onChanged: (value) {
                          setState(() {
                            selectNumber = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),
          );
// Scaffold를 이용해 전체 화면 구성
          return Scaffold(
            appBar: AppBar(title: Text(title)), // [p.92] 상단 제목 표시
            body: Column(
              children: [
// [p.93] 질문 본문 출력
                Text(questions['question'].toString()),
// [p.93] Expanded + ListView로 선택지 스크롤 가능 구조 구성
                Expanded(
                  child: ListView.builder(
                    itemCount: widgets.length,
                    itemBuilder: (context, index) {
                      final item = widgets[index];
                      return item;
                    },
                  ),
                ),
// [p.94] 선택되지 않은 경우 버튼 미표시, 선택 시 ‘성적 보기’ 버튼 활성화
                selectNumber == -1
                    ? Container()
                    : ElevatedButton(
                  onPressed: () async {
// [p.98] FirebaseAnalytics 이벤트 로깅 (선택 결과 전송)
                    try {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'personal_select',
                        parameters: {
                          'test_name': title,
                          'select': selectNumber,
                        },
                      );
// [p.95] 결과 페이지로 이동 (pushReplacement)
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailPage(
                              answer: questions['answer'][selectNumber],
                              question: questions['question'],
                            );
                          },
                        ),
                      );
                    } catch (e) {
                      print('Failed to log event: $e');
                    }
                  },
                  child: const Text('성적 보기'),
                ),
              ],
            ),
          );
        }
// [p.93] 데이터 로드 실패 시 오류 표시
        else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
// [보조] 예외적 빈 상태 처리
        else {
        return const SizedBox.shrink();
        }
      },
    );
  }
}