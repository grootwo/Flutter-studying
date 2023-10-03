import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool check = true;

  void toggleText() {
    setState(() {
      check = !check;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.greenAccent,
            fontSize: 60,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              check
                  ? const MyLargeTitle()
                  : const Text(
                      'Bye',
                      style: TextStyle(
                        fontSize: 60,
                      ),
                    ),
              IconButton(
                  onPressed: toggleText,
                  icon: const Icon(Icons.ads_click_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatelessWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
}
