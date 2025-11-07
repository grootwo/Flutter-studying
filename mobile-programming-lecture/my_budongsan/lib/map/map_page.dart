// lib/map/map_page.dart
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // ✅ 추가: 구글 지도 패키지
import 'map_filter.dart';          // 필터 데이터 클래스 import
import 'map_filter_dialog.dart';  // 필터 대화 상자 클래스 import

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  int currentItem = 0; // 현재 선택된 하단 메뉴 인덱스
  MapFilter mapFilter = MapFilter(); // 필터 상태 저장용 객체 생성

  // ✅ 수정: 제네릭 명시한 Completer
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  // ✅ 추가: 지도에 표시할 마커 집합
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // ✅ 수정: 교재 기준 초기 카메라 위치 (성북구 근처)
  static const CameraPosition _googleMapCamera = CameraPosition(
    target: LatLng(37.571320, 127.029043),
    zoom: 15.0,
  );

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
          // ✅ 수정: 필터 대화 상자 호출 로직
          IconButton(
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MapFilterDialog(mapFilter);
                  },
                ),
              );

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
              decoration: BoxDecoration(color: Colors.blue),
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

      // ✅ 수정: 현재 탭에 따라 지도 or 리스트 표시
      body: currentItem == 0
          ? GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _googleMapCamera,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        },
        markers: Set<Marker>.of(markers.values),
      )
          : ListView(),

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
        onPressed: () async {
          // ✅ 추가: 현재 위치 기준 지도 이동 예시
          final GoogleMapController controller = await _controller.future;
          await controller.animateCamera(
            CameraUpdate.newLatLngZoom(const LatLng(37.571320, 127.029043), 15),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('현재 위치로 지도 이동 완료')),
          );
        },
        label: const Text('이 위치로 검색하기'),
      ),
    );
  }
}
