import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const Flexible(
            flex: 1,
            child: Text('25:00'),
          ),
          Flexible(
              flex: 1,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.play_circle_filled_sharp),
                  onPressed: () {},
                ),
              )),
          Flexible(
            flex: 1,
            child: Expanded(
                child: Row(
              children: [
                Column(
                  children: const [
                    Text('Pomodoros'),
                    Text('0'),
                  ],
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
