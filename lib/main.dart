import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rnd/router/app_router.gr.dart';
import 'package:flutter_rnd/router/guards/auth_guard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      startLocale: Locale('ja'),
      supportedLocales: [Locale('ja')],
      child: ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

final appRouterProvider =
    Provider((ref) => AppRouter(authGuard: ref.watch(authGuardProvider)));

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                  child: Text(
                      "Something wrong happened while iniliazing firebase 🔥: \n" +
                          snapshot.error.toString())),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(builder: (context, ref, _) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routeInformationParser:
                    ref.watch(appRouterProvider).defaultRouteParser(),
                routerDelegate: ref.watch(appRouterProvider).delegate(),
              );
            });
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        future: _initialization,
      ),
    );
  }
}
