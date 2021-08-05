import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key, @PathParam("testName") this.testName})
      : super(key: key);

  final String? testName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello $testName"),
      ),
      body: Center(
        child: Text("Check my name in app bar"),
      ),
    );
  }
}
