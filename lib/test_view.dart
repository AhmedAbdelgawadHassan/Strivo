import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text('Test View',style: TextStyle(color: Colors.white,fontSize: 40),))),
    );
  }
}