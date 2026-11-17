import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Testing View",style: TextStyle(fontSize: 50,color: Colors.white),),
      ),
    );

  }
}