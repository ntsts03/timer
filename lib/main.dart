import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer3/next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'タイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _minutes = 0;
  int _second = 0;
  int _milliseconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _minutes.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 80,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    fontSize: 80,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                Text(
                  _second.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 80,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    fontSize: 80,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                Text(
                  _milliseconds.toString().padLeft(3, '0').substring(0, 2),
                  style: const TextStyle(
                    fontSize: 80,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                toggleTimer();
              },
              child: Text(
                _isRunning ? 'ストップ' : 'スタート',
                style: TextStyle(
                  color: _isRunning ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                restTimer();
              },
              child: const Text(
                'リセット',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(
        const Duration(milliseconds: 1),
        (timer) {
          setState(() {
            _milliseconds++;

            if (_milliseconds >= 1000) {
              _second++;
              _milliseconds = 0;
            }

            if (_second >= 60) {
              _minutes++;
              _second = 0;
            }
          });
          if (_second == 10) {
            restTimer();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NextPage()),
            );
          }
        },
      );
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void restTimer() {
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _second = 0;
      _minutes = 0;
      _isRunning = false;
    });
  }
}
