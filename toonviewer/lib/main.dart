import 'package:flutter/material.dart';

import 'widgets/button.dart';

void main() {
  runApp(const App());
}

// flutter is all about widget
// StatelessWidget show screens
class App extends StatelessWidget {
  const App({super.key});

  // must build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color(0xFF181818),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          'Hey Halo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '\$8 365 239',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Button(
                        text: 'Transfer',
                        textColor: Colors.black,
                        bgColor: Colors.amber),
                    Button(
                        text: 'Request',
                        textColor: Colors.white,
                        bgColor: Color(0xFF1F2123)),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: const [
                    Text(
                      'Wallets',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 25,
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
