// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/home_screen.dart' as _i6;
import '../screens/login_screen.dart' as _i4;
import '../screens/register_screen.dart' as _i5;
import 'guards/auth_guard.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i3.AuthGuard authGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MainRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterScreen();
        }),
    LoginRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
          return _i4.LoginScreen(key: args.key);
        }),
    RegisterRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RegisterRouteArgs>(
              orElse: () => const RegisterRouteArgs());
          return _i5.RegisterScreen(key: args.key);
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.HomeScreen();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MainRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i1.RouteConfig('#redirect',
              path: '', redirectTo: 'home', fullMatch: true),
          _i1.RouteConfig(HomeRoute.name, path: 'home')
        ]),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(RegisterRoute.name, path: '/register')
      ];
}

class MainRoute extends _i1.PageRouteInfo {
  const MainRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'MainRoute';
}

class LoginRoute extends _i1.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i2.Key? key})
      : super(name, path: '/login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i2.Key? key;
}

class RegisterRoute extends _i1.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({_i2.Key? key})
      : super(name, path: '/register', args: RegisterRouteArgs(key: key));

  static const String name = 'RegisterRoute';
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i2.Key? key;
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: 'home');

  static const String name = 'HomeRoute';
}
