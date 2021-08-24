import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rnd/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final batteryLevelProvider = StateProvider((ref) => 'Unknown battery level');

  static const platform = MethodChannel("flutter.dev/home-screen");

  Future<void> _getBatteryLevel(WidgetRef ref) async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      ref.read(batteryLevelProvider).state = 'Battery level is at $result % .';
    } on PlatformException catch (e) {
      ref.read(batteryLevelProvider).state =
          'Failed to get battery level: ${e.message}';
    } catch (e) {
      ref.read(batteryLevelProvider).state = "Failed: ${e.toString()}";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authServiceProvider).maybeWhen(
          user: (u) => u,
          orElse: () {},
        );

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
                  "${tr('Hello')} ${user?.displayName ?? ""}",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(ref.watch(batteryLevelProvider).state),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () => _getBatteryLevel(ref),
          child: Icon(Icons.refresh),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(15),
          ),
        ));
  }
}
