import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honeybee/data/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user.dart';
import '../auth/auth_page.dart';
import '../hobby/hobby_selection_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IntroPage();
  }
}

class _IntroPage extends State<IntroPage> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isDialogOpen = false;

  late HoneyBeeUser user;

  Future<bool> _notiPermissionCheck() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<bool> _loginCheck() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    String? pw = preferences.getString('pw');
    String? hobby = preferences.getString('hobby');

    if (id != null && pw != null) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      try {
        await auth.signInWithEmailAndPassword(email: id, password: pw);
        user = HoneyBeeUser(
          email: auth.currentUser!.email!,
          uid: auth.currentUser!.uid,
        );
        user.hobby = hobby; // 취미 정보 넣기
        Get.lazyPut(() => user);

        await Future.delayed(const Duration(seconds: 2));
        return true;
      } on FirebaseAuthException catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _handleConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _handleConnectionStatus(result);
  }

  void _handleConnectionStatus(List<ConnectivityResult> result) {
    for (var element in result) {
      if (element == ConnectivityResult.mobile ||
          element == ConnectivityResult.wifi) {
        if (_isDialogOpen) {
          Navigator.of(context).pop();
          _isDialogOpen = false;
        }
      } else {
        _showOfflineDialog();
      }
    }
  }

  void _showOfflineDialog() {
    if (!_isDialogOpen && mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          _isDialogOpen = true;
          return AlertDialog(
            title: const Text('허니비 앱'),
            content: const Text(
              '지금 인터넷에 연결되지 않아 허니비 앱을 사용할 수 없습니다.\n'
                  '나중에 다시 실행해 주세요.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _isDialogOpen = false;
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      ).then((_) => _isDialogOpen = false);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _notiPermissionCheck(),
        builder: (buildContext, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return introView();
            case ConnectionState.waiting:
              return introView();
            case ConnectionState.active:
              return introView();
            case ConnectionState.done:

            /// ----------------------------
            /// 로그인 결과 처리
            /// ----------------------------
              _loginCheck().then((value) {
                if (value == true) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.snackbar(Constant.APP_NAME, '로그인 되었습니다');

                    /// ★ 취미 등록 여부 체크
                    if (user.hobby != null && user.hobby!.isNotEmpty) {
                      // 메인 페이지로 이동 로직이 필요하면 여기에 작성
                      // Get.off(MainPage());
                    } else {
                      Get.off(const HobbySelectionPage());
                    }
                  });
                } else {
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.off(const AuthPage());
                  });
                }
              });

              return introView();
          }
        },
      ),
    );
  }

  Widget introView() {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              Constant.APP_NAME,
              style: TextStyle(fontSize: 50, fontFamily: 'paperlogy'),
            ),
            const SizedBox(height: 20),
            Lottie.asset('res/animation/honeybee.json'),
          ],
        ),
      ),
    );
  }
}
