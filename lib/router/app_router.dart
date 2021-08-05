import 'package:auto_route/annotations.dart';
import 'package:flutter_rnd/screens/home.dart';
import 'package:flutter_rnd/screens/test_screen.dart';

@MaterialAutoRouter(replaceInRouteName: "Screen,Route", routes: <AutoRoute>[
  AutoRoute(page: HomeScreen, initial: true),
  AutoRoute(page: TestScreen),
])
class $AppRouter {}
