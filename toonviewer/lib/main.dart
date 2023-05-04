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
              MyTitle(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTitle extends StatefulWidget {
  const MyTitle({
    super.key,
  });

  @override
  State<MyTitle> createState() => _MyTitleState();
}

class _MyTitleState extends State<MyTitle> {
  @override
  void initState() {
    super.initState();
    print("init");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Text(
      'This is my TITLE!',
      style: TextStyle(
        color: Theme.of(context).textTheme.titleMedium?.color,
        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
      ),
    );
  }
}
