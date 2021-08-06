import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rnd/router/app_router.gr.dart';

void main() {
  runApp(MyApp());
}

final _appRouter = AppRouter();

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
            return MaterialApp.router(
              routeInformationParser: _appRouter.defaultRouteParser(),
              routerDelegate: _appRouter.delegate(),
            );
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
