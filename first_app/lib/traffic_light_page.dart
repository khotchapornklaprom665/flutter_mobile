import 'package:flutter/material.dart';

class TrafficLightPage extends StatefulWidget {
  const TrafficLightPage({super.key});

  @override
  State<TrafficLightPage> createState() => _TrafficLightPageState();
}

class _TrafficLightPageState extends State<TrafficLightPage> {
  int currentLight = 0;

  void changeLight() {
    setState(() {
      currentLight = (currentLight + 1) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traffic Light Animation'),  backgroundColor: Colors.deepPurple,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: currentLight == 0 ? 1.0 : 0.3,
              duration: const Duration(seconds: 1),
              child: buildLight(Colors.red),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: currentLight == 1 ? 1.0 : 0.3,
              duration: const Duration(seconds: 1),
              child: buildLight(Colors.yellow),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: currentLight == 2 ? 1.0 : 0.3,
              duration: const Duration(seconds: 1),
              child: buildLight(Colors.green),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: changeLight,
              child: const Text('เปลี่ยนไฟ'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLight(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}
