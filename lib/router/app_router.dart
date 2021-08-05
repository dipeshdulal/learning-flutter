import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_rnd/screens/books_screen/books.dart';
import 'package:flutter_rnd/screens/books_screen/books_detail.dart';
import 'package:flutter_rnd/screens/home_screen.dart';
import 'package:flutter_rnd/screens/test_screen.dart';

@MaterialAutoRouter(replaceInRouteName: "Screen,Route", routes: <AutoRoute>[
  AutoRoute(page: HomeScreen, initial: true, path: "/"),
  AutoRoute(page: TestScreen, path: "/test/:testName"),
  AutoRoute(
      page: EmptyRouterPage,
      path: "/books",
      name: "BooksMainRoute",
      children: [
        AutoRoute(page: BooksScreen, path: ""),
        AutoRoute(page: BooksDetailScreen, path: ":bookId"),
      ])
])
class $AppRouter {}
