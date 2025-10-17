import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart'; // p.98
import '../detail/detail_page.dart'; // p.115

class QuestionPage extends StatefulWidget {
  final Map<String, dynamic> question; // p.113: String -> Map 으로 변경
  const QuestionPage({super.key, required this.question});

  @override
  State<QuestionPage> createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {
  String title = "";
  int? selectedOption; // p.114: 선택 인덱스 (null 허용)

  @override
  void initState() {
    super.initState();
    title = widget.question['title'] as String; // p.114: 제목 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 문제 본문
            Text(
              widget.question['question'] as String,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 선택지 목록
            Expanded(
              child: ListView.builder(
                itemCount:
                (widget.question['selects'] as List<dynamic>).length,
                itemBuilder: (context, index) {
                  return RadioListTile<int>(
                    title: Text((widget.question['selects'][index]) as String),
                    value: index,
                    groupValue: selectedOption,
                    // 최신 Flutter null-safety 반영
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  );
                },
              ),
            ),

            // p.115: 버튼 위에 spacer 추가
            const SizedBox(height: 20),

            // 결과 보기 버튼
            Center(
              child: ElevatedButton(
                onPressed: selectedOption == null
                    ? null
                    : () async {
                  try {
                    await FirebaseAnalytics.instance.logEvent(
                      name: 'personal_select',
                      parameters: {
                        'test_name': title,
                        'select': selectedOption ?? 0,
                      },
                    );

                    await Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                      builder: (context) => DetailPage(
                        answer: widget
                            .question['answer'][selectedOption ?? 0],
                        question: widget.question['question'],
                      ),
                    ));
                  } catch (e) {
                    print('Failed to log event: $e');
                  }
                },
                child: const Text('성적 보기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
