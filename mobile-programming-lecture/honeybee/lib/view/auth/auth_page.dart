import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:honeybee/data/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPage createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  // Firebase Auth 객체 생성하기
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 이메일과 비밀번호 입력 컨트롤러 생성하기
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 이메일과 비밀번호로 회원 가입하는 메서드
  void _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        Get.snackbar(Constant.APP_NAME, '회원 가입 성공');
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        Get.snackbar(Constant.APP_NAME, e.message!);
      });
    }
  }

  // 비밀번호 재설정 이메일을 발송하는 메서드
  void _findPassword() async {
    String email = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('비밀번호 초기화'),
          content: TextFormField(
            decoration: InputDecoration(hintText: 'Enter your email'),
            onChanged: (value) {
              email = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _auth.sendPasswordResetEmail(email: email);
                Get.snackbar(Constant.APP_NAME, "메일 전송 완료");
                Get.back();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // 이메일과 비밀번호로 로그인하는 메서드
  void _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        Get.snackbar(Constant.APP_NAME, '로그인 성공');
      });

      HoneyBeeUser user = HoneyBeeUser(
        email: _emailController.text,
        uid: _auth.currentUser?.uid,
      );
      Get.lazyPut(() => user);

      var token = await FirebaseMessaging.instance.getToken();

      final SharedPreferences preferences =
      await SharedPreferences.getInstance();
      await preferences.setString("id", _emailController.text);
      await preferences.setString("pw", _passwordController.text);
      await preferences.setBool("hobbyNoti", true);
      await preferences.setBool("commentNoti", true);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_emailController.text)
          .set({
        'email': _emailController.text,
        'fcm': token,
        'uid': _auth.currentUser?.uid,
        'hobbyNoti': true,
        'commentNoti': true,
      }).then((value) {

      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        Get.snackbar(Constant.APP_NAME, e.message!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '허니비',
                style: TextStyle(fontFamily: 'clover', fontSize: 30),
              ),
              Lottie.asset(
                'res/animation/honeybee.json',
                width: MediaQuery.of(context).size.width / 2,
              ),

              // 이메일 입력 필드
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이메일',
                  hintText: 'example@example.com',
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.check),
                ),
              ),

              SizedBox(height: 20),

              // 비밀번호 입력 필드
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '비밀번호',
                  hintText: '6자 이상',
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.check),
                ),
                obscureText: true,
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _signUp,
                    child: Text('회원 가입'),
                  ),
                  ElevatedButton(
                    onPressed: _signIn,
                    child: Text('로그인'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _findPassword,
                child: Text('비밀번호 찾기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
