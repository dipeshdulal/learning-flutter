import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rnd/router/app_router.gr.dart';

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
              Text("Hello world!"),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).navigate(TestRoute());
                },
                child: Text("Goto Next Page"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
