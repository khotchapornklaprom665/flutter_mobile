import 'package:first_app/second_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SecondPage()),
              );
            }, 
            child: Text('Second Page >'))
          ],
        ),
      ),
    );
  }
}