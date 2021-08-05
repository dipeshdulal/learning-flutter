import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Hello world!"),
              ),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).navigateNamed("/test/Dipesh");
                },
                child: Text("Goto Next Page"),
              ),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).pushNamed("/books");
                },
                child: Text("Goto Books Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
