import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_rnd/router/guards/auth_guard.dart';
import 'package:flutter_rnd/screens/home_screen.dart';
import 'package:flutter_rnd/screens/login_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: "Screen,Route",
  routes: <AutoRoute>[
    AutoRoute(
      page: EmptyRouterScreen,
      path: "/",
      initial: true,
      name: "MainRoute",
      guards: [AuthGuard],
      children: [
        AutoRoute(
          page: HomeScreen,
          path: "home",
          initial: true,
        ),
      ],
    ),
    AutoRoute(page: LoginScreen, path: "/login"),
  ],
)
class $AppRouter {}
