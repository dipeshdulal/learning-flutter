import 'package:auto_route/auto_route.dart';
import 'package:flutter_rnd/router/app_router.gr.dart';
import 'package:flutter_rnd/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final container = ProviderContainer();
    final authState = container.read(authServiceProvider);

    if (resolver.route.routeName != LoginRoute.name && !authState.loggedIn) {
      router.pushNamed("/login");
      return null;
    }

    resolver.next(true);
  }
}
