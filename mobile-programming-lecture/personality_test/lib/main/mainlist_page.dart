// 이 파일은 앱의 첫 화면으로, JSON 데이터를 불러와 목록 형태로 표시합니다.
// ‘비동기 데이터 처리’와 ‘화면 전환(Navigator)’의 기본 흐름을 설명하는 파트입니다.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../sub/question_page.dart'; // [p.92] QuestionPage로 화면 이동을 위한 import
import 'package:firebase_analytics/firebase_analytics.dart'; // [p.97] 클릭 이벤트 로그 전송용 Firebase Analytics
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
// [p.84] 비동기 JSON 파일 로드 함수
// assets 폴더(res/api/list.json)에 저장된 테스트 목록 데이터를 불러옵니다.
// rootBundle은 Flutter의 내장 리소스 접근 도구입니다.
  Future<String> loadAsset() async {
    return await rootBundle.loadString('res/api/list.json');
  }
  @override
  Widget build(BuildContext context) {
// [p.85] Scaffold: 화면의 기본 뼈대 위젯
// body 부분에서 FutureBuilder를 통해 데이터 로드 상태에 따라 UI를 다르게 표시합니다.
    return Scaffold(
      body: FutureBuilder<String>(
// [p.85] future 속성: 비동기 작업(Future)을 지정
        future: loadAsset(),
// [p.86] builder: Future의 진행 상태에 따라 UI를 구성
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
// [p.86] 데이터 로드 중: 로딩 인디케이터 표시
// CircularProgressIndicator는 비동기 작업 진행 상태를 시각적으로 보여줍니다.
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
// [p.87] 데이터 로드 완료 시
              if (snapshot.hasData) {
// [p.87] JSON 문자열을 Map 구조로 변환
                Map<String, dynamic> list = jsonDecode(snapshot.data!);
// [p.88] ListView.builder: 동적 리스트 생성
// itemCount로 항목 개수를 지정하고, itemBuilder로 각 항목의 UI를 만듭니다.
                return ListView.builder(
                  itemCount: list['count'],
                  itemBuilder: (context, index) {
// [p.89] InkWell: 탭(클릭) 가능한 위젯
// [교수 설명용] InkWell은 사용자 인터랙션(눌림 효과)을 시각적으로 제공함
                    return InkWell(
                      onTap: () async {
                        try {
// [p.97] FirebaseAnalytics 이벤트 로깅
// 사용자가 테스트 항목을 클릭할 때마다 ‘test_click’ 이벤트를 전송합니다.
// parameters를 통해 어떤 테스트를 클릭했는지 서버로 기록합니다.
                          await FirebaseAnalytics.instance.logEvent(
                            name: 'test_click',
                            parameters: {
                              'test_name': list['questions'][index]['title'].toString(),
                            },
                          );
// [p.92] Navigator.push(): 새로운 화면(QuestionPage)으로 이동
// MaterialPageRoute를 사용하여 다음 화면으로 전환합니다.
// list['questions'][index]['file']을 전달해 부 질문 페이지를 로드합니다.
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return QuestionPage(
                                  question: list['questions'][index]['file'].toString(),
                                );
                              },
                            ),
                          );
                        } catch (e) {
// [보조 설명] Firebase 로그 실패 시 콘솔에 오류 출력
                          print('Failed to log event: $e');
                        }
                      },
// [p.88] Card 위젯: 리스트 항목을 카드 형태로 시각화
// 각 테스트 제목을 시각적으로 구분하여 표시합니다.
                      child: SizedBox(
                        height: 50,
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.check),
                            title: Text(list['questions'][index]['title']),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          )
                        ),
                      ),
                    );
                  },
                );
              }
// [p.86] 에러 처리: snapshot.hasError일 경우
              else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
// [p.86] 데이터 없음 처리
              else {
                return const Center(
                  child: Text('No Data'),
                );
              }
// [보조 설명] 기본 상태: 예외적으로 연결되지 않은 경우
            default:
              return const Center(
                child: Text('No Data'),
              );
          }
        },
      ),
    );
  }
}