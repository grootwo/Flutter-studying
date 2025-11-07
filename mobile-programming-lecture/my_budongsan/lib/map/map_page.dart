// lib/map/map_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'map_filter.dart';          // 추가: 필터 데이터 클래스 import
import 'map_filter_dialog.dart';  // 추가: 필터 대화 상자 클래스 import

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  int currentItem = 0; // 현재 선택된 하단 메뉴 인덱스
  MapFilter mapFilter = MapFilter(); // 추가: 필터 상태 저장용 객체 생성

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My 부동산'),
        actions: [
          // 수정: onPressed에 필터 대화 상자 호출 로직 추가
          IconButton(
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MapFilterDialog(mapFilter); // 추가: 필터 대화 상자 호출
                  },
                ),
              );

              // 추가: 사용자가 필터를 설정하고 '확인'을 눌렀을 때 결과 반영
              if (result != null) {
                setState(() {
                  mapFilter = result as MapFilter;
                });
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '조익성',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ischo4045@daegu.ac.kr',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('내가 선택한 아파트'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('설정'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: currentItem == 0 ? Container() : ListView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentItem,
        onTap: (value) {
          setState(() {
            currentItem = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'map',
            icon: Icon(Icons.map),
          ),
          BottomNavigationBarItem(
            label: 'list',
            icon: Icon(Icons.list),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('이 위치로 검색하기'),
      ),
    );
  }
}
