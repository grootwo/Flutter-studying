// lib/map/map_page.dart
// 지도 기반 Firestore 데이터 시각화 및 geoFire 반경 검색 예제
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ✅ 추가: Firestore 및 geoFire 관련 패키지 임포트
import 'package:cloud_firestore/cloud_firestore.dart';
import '../geoFire/geoflutterfire.dart';
import '../geoFire/models/point.dart';

import 'map_filter.dart';
import 'map_filter_dialog.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  int currentItem = 0; // 현재 하단 탭 상태
  MapFilter mapFilter = MapFilter(); // 필터 정보 저장 객체

  late Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>(); // ✅ 수정: 재생성 가능하도록 late 사용

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // 지도 마커 집합
  MarkerId? selectedMarker;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker; // 커스텀 아이콘 변수
  late List<DocumentSnapshot> documentList =
  List<DocumentSnapshot>.empty(growable: true); // Firestore 데이터 리스트

  static const CameraPosition _googleMapCamera = CameraPosition(
    target: LatLng(37.571320, 127.029043), // 서울 성북구 중심 좌표
    zoom: 15.0,
  );

  @override
  void initState() {
    super.initState();
    addCustomIcon();
  }

  // ✅ 사용자 정의 마커 아이콘 생성
  void addCustomIcon() {
    BitmapDescriptor.asset(
      const ImageConfiguration(),
      'res/images/apartment.png',
      width: 50,
      height: 50,
    ).then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  // ✅ Firestore + geoFire 기반 지도 반경 검색
  Future<void> _searchApt() async {
    final GoogleMapController controller = await _controller.future;
    final bounds = await controller.getVisibleRegion();

    final LatLng centerBounds = LatLng(
      (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
      (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
    );

    final aptRef = FirebaseFirestore.instance.collection('cities');
    final geo = Geoflutterfire();

    final GeoFirePoint center = geo.point(
      latitude: centerBounds.latitude,
      longitude: centerBounds.longitude,
    );

    const double radius = 50; // 🔍 반경 확장 (테스트용)
    const String field = 'position';

    final Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: aptRef)
        .within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      this.documentList = documentList;
      _drawMarkers(documentList);
    });
  }

  // ✅ Firestore 결과 기반 마커 생성
  void _drawMarkers(List<DocumentSnapshot> documentList) {
    setState(() {
      markers.clear();
    });

    for (final DocumentSnapshot doc in documentList) {
      final Map<String, dynamic> info = doc.data() as Map<String, dynamic>;

      if (selectedCheck(
        info,
        mapFilter.peopleString,
        mapFilter.carString,
        mapFilter.buildingString,
      )) {
        final MarkerId markerId = MarkerId(info['position']['geohash']);
        final Marker marker = Marker(
          markerId: markerId,
          infoWindow: InfoWindow(
            title: info['name'],
            snippet: info['address'],
          ),
          position: LatLng(
            (info['position']['geopoint'] as GeoPoint).latitude,
            (info['position']['geopoint'] as GeoPoint).longitude,
          ),
          icon: markerIcon,
        );

        setState(() {
          markers[markerId] = marker;
        });
      }
    }
  }

  // ✅ 필터 조건 비교
  bool selectedCheck(
      Map<String, dynamic> info,
      String? peopleString,
      String? carString,
      String? buildingString,
      ) {
    final dong = info['ALL_DONG_CO'];
    final people = info['ALL_HSHLD_CO'];
    final parking = people / info['CNT_PA'];

    if (dong < int.parse(buildingString!)) return false;
    if (people < int.parse(peopleString!)) return false;

    if (carString == '1') {
      return parking < 1;
    } else {
      return parking >= 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My 부동산'),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapFilterDialog(mapFilter),
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
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('조익성',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text('ischo4045@daegu.ac.kr',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            ListTile(title: Text('내가 선택한 아파트')),
            ListTile(title: Text('설정')),
          ],
        ),
      ),

      // ✅ 수정: 지도 ↔ 목록 전환 구현
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
          : ListView.builder(
        itemBuilder: (context, value) {
          Map<String, dynamic> item =
          documentList[value].data() as Map<String, dynamic>;
          return InkWell(
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.apartment),
                title: Text(item['name']),
                subtitle: Text(item['address']),
                trailing:
                const Icon(Icons.arrow_circle_right_sharp),
              ),
            ),
            onTap: () {},
          );
        },
        itemCount: documentList.length,
      ),

      // ✅ 수정: 지도 복원 로직 추가
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentItem,
        onTap: (value) {
          if (value == 0) {
            _controller = Completer<GoogleMapController>();
          }
          setState(() {
            currentItem = value;
          });
        },
        items: const [
          BottomNavigationBarItem(label: 'map', icon: Icon(Icons.map)),
          BottomNavigationBarItem(label: 'list', icon: Icon(Icons.list)),
        ],
      ),

      // ✅ FloatingActionButton: 지도 중심 Firestore 검색
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _searchApt,
        label: const Text('이 위치로 검색하기'),
      ),
    );
  }
}
