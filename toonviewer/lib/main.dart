import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _ApptState();
}

class _ApptState extends State<App> {
  List<num> numList = [];
  void onclicked() {
    setState(() {
      numList.add(numList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: Colors.green[300],
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              myTitle(),
            ],
          ),
        ),
      ),
    );
  }
}

class myTitle extends StatelessWidget {
  const myTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('This is my TITLE!');
  }
}
