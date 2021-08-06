import 'package:auto_route/auto_route.dart';
import 'package:flutter_rnd/router/app_router.gr.dart';
import 'package:flutter_rnd/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authGuardProvider = Provider((ref) => AuthGuard(ref: ref));

class AuthGuard extends AutoRouteGuard {
  ProviderRef ref;

  AuthGuard({required this.ref});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final loggedIn = this.ref.read(authServiceProvider).loggedIn;
    if (resolver.route.routeName != LoginRoute.name && !loggedIn) {
      router.replaceNamed("/login");
      return null;
    }

    resolver.next(true);
  }
}
