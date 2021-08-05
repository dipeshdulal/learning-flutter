// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/books_screen/books.dart' as _i5;
import '../screens/books_screen/books_detail.dart' as _i6;
import '../screens/home_screen.dart' as _i3;
import '../screens/test_screen.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomeScreen();
        }),
    TestRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<TestRouteArgs>(
              orElse: () =>
                  TestRouteArgs(testName: pathParams.optString('testName')));
          return _i4.TestScreen(key: args.key, testName: args.testName);
        }),
    BooksMainRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    BooksRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.BooksScreen();
        }),
    BooksDetailRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<BooksDetailRouteArgs>(
              orElse: () =>
                  BooksDetailRouteArgs(bookId: pathParams.optString('bookId')));
          return _i6.BooksDetailScreen(key: args.key, bookId: args.bookId);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(TestRoute.name, path: '/test/:testName'),
        _i1.RouteConfig(BooksMainRoute.name, path: '/books', children: [
          _i1.RouteConfig(BooksRoute.name, path: ''),
          _i1.RouteConfig(BooksDetailRoute.name, path: ':bookId')
        ])
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class TestRoute extends _i1.PageRouteInfo<TestRouteArgs> {
  TestRoute({_i2.Key? key, String? testName})
      : super(name,
            path: '/test/:testName',
            args: TestRouteArgs(key: key, testName: testName),
            rawPathParams: {'testName': testName});

  static const String name = 'TestRoute';
}

class TestRouteArgs {
  const TestRouteArgs({this.key, this.testName});

  final _i2.Key? key;

  final String? testName;
}

class BooksMainRoute extends _i1.PageRouteInfo {
  const BooksMainRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/books', initialChildren: children);

  static const String name = 'BooksMainRoute';
}

class BooksRoute extends _i1.PageRouteInfo {
  const BooksRoute() : super(name, path: '');

  static const String name = 'BooksRoute';
}

class BooksDetailRoute extends _i1.PageRouteInfo<BooksDetailRouteArgs> {
  BooksDetailRoute({_i2.Key? key, String? bookId})
      : super(name,
            path: ':bookId',
            args: BooksDetailRouteArgs(key: key, bookId: bookId),
            rawPathParams: {'bookId': bookId});

  static const String name = 'BooksDetailRoute';
}

class BooksDetailRouteArgs {
  const BooksDetailRouteArgs({this.key, this.bookId});

  final _i2.Key? key;

  final String? bookId;
}
