// 선택한 질문과 답변을 표시하는 최종 결과 화면
// Navigator를 통해 전달받은 데이터를 표시하고, '돌아가기' 버튼으로 이전 화면으로 복귀합니다.
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String answer; // [p.96] 이전 페이지에서 전달받은 선택 결과
  final String question; // [p.96] 이전 페이지에서 전달받은 질문 내용
  const DetailPage({super.key, required this.answer, required this.question});

  @override
  State<DetailPage> createState() {
    // [p.96] 원문 구조 그대로 return 문을 사용하여 상태 객체를 반환
    return _DetailPage();
  }
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // [p.97] Scaffold: 화면의 기본 구조 생성
    // [p.98] body에 Center와 Column을 사용하여 수직 정렬된 결과 구성
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // [p.98] 질문 내용 표시
            Text(widget.question),
            // [p.99] 선택한 답변 내용 표시
            Text(widget.answer),
            // [p.100] ElevatedButton: '돌아가기' 버튼
            // Navigator.pop()을 이용하여 이전 화면(QuestionPage)으로 복귀
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("새 테스트를 시작할 수 있습니다")),
                );
                Navigator.of(context).pop();
              },
              child: const Text('메인으로 돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}
