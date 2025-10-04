import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  void _increment() {
    setState(() {
      counter++;
    });
  }

  void _decrement() {
    setState(() {
      counter--;
    });
  }

  void _reset() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter Value:'),
            const SizedBox(height: 10),
            Text(
              '$counter',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _increment,
                  child: const Text('+ Increment'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _decrement,
                  child: const Text('- Decrement'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}