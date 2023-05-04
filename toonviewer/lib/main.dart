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
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Color.fromARGB(255, 0, 179, 9),
            fontSize: 40,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 208, 3),
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
    return Text(
      'This is my TITLE!',
      style: TextStyle(
        color: Theme.of(context).textTheme.titleMedium?.color,
        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
      ),
    );
  }
}
