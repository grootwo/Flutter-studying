import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // JSON 파일 불러오기용
import 'dart:convert'; // JSON decode 용
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPage();
}
class _MainPage extends State<MainPage> {
  // JSON 파일을 비동기적으로 로드하는 함수
  Future<String> loadAsset() async {
    return await rootBundle.loadString('res/api/list.json');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<String>(
            future: loadAsset(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              // 로딩 중일 때 원형 로딩 표시
              return const Center(
              child: CircularProgressIndicator(),
              );
              case ConnectionState.done:
              if (snapshot.hasData) {
              // JSON 파싱
              Map<String, dynamic> list = jsonDecode(snapshot.data!);
              return ListView.builder(
              itemCount: list['count'],
              itemBuilder: (context, index) {
              return InkWell(
              onTap: () {
              // 클릭 시 동작 추가 가능
              },
              child: SizedBox(
              height: 50,
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
                // 에러가 발생했을 때
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // 데이터가 없을 때
                return const Center(
                  child: Text('No Data'),
                );
              }
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