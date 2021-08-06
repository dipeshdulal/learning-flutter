import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rnd/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                await ref.read(authServiceProvider.notifier).signOut();
                AutoRouter.of(context).replaceNamed("/login");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to home",
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
