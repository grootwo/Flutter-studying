// Flutter 앱은 항상 main() 함수에서 시작합니다.
// runApp()이 호출되면 앱의 전체 위젯 트리가 구성되고,
// MyApp이 최상위(root) 위젯으로서 전체 화면의 뼈대를 담당합니다.
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // [p.96] Firebase 기능 사용을 위한 기본 패키지
import 'firebase_options.dart'; // [p.96] Firebase 프로젝트별 설정 옵션 자동 생성 파일
import 'main/mainlist_page.dart'; // [p.82] 메인 리스트 화면 연결

// [p.96] main()은 비동기(async)로 선언되어 Firebase 초기화를 기다립니다.
// Flutter 앱 실행 전에 Firebase 서비스를 사용하려면 반드시 비동기 초기화 과정이 필요합니다.
// WidgetsFlutterBinding.ensureInitialized()는 runApp() 전에 Flutter 엔진과 위젯 바인딩을 완료시킵니다.
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // [p.96] Firebase 초기화 전 필수 호출
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // [p.96] 플랫폼별 Firebase 설정값 불러오기
  );
  runApp(const MyApp()); // [p.79] MyApp 위젯 실행 → 앱 시작
}

// [p.80~82] MyApp: 앱의 최상위(루트) 위젯
// StatelessWidget은 상태가 변하지 않는 정적 화면 구조를 표현합니다.
// 앱의 전반적인 테마, 색상, 첫 화면(home) 등 변하지 않는 설정을 담당합니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: 앱 전반의 전역 설정(테마, 제목, 초기 화면 등)을 관리
    // [교수 설명용] 학생들에게 MaterialApp이 ‘앱의 계관(World)’을 정의하는 틀임을 강조해 주요.
    // 모든 위젯은 이 안에서 하나의 계층적 트리로 연결됩니다.
    return MaterialApp(
      title: 'Personality Test', // [p.82] 앱 제목 (디버그용 표시 또는 상단 제목)
      theme: ThemeData(
        // [p.81] ThemeData: 앱의 일관된 색상과 스타일을 정의
        // ColorScheme.fromSeed()는 시드(seed) 색상 하나로 전체 팔레트를 자동 생성합니다.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true, // [p.81] 최신 Material Design 3 스타일 적용
      ),
      // [p.82] home: 앱이 실행될 때 처음 표시되는 화면 위젯
      // 여기서는 MainPage()가 앱의 첫 화면이며,
      // 리스트 형태로 성격 테스트 항목을 보여주는 구조입니다.
      home: const MainPage(),
    );
  }
}
