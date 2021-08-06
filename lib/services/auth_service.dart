import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  return AuthService(auth: ref.watch(firebaseAuthProvider));
});

class AuthService extends StateNotifier<AuthState> {
  AuthService({required this.auth}) : super(AuthState(isLoading: false)) {
    this.auth.userChanges().listen(authChanged);
  }

  final FirebaseAuth auth;

  registerUser({String email = "", String password = ""}) async {
    try {
      state = AuthState.withLoading(true);
      UserCredential cred = await this
          .auth
          .createUserWithEmailAndPassword(email: email, password: password);
      state = AuthState.withUser(cred.user);
      return cred.user;
    } catch (e) {
      state = AuthState.withError(e.toString());
    }
  }

  signIn({String email = "", String password = ""}) async {
    try {
      state = AuthState.withLoading(true);
      UserCredential cred = await this
          .auth
          .signInWithEmailAndPassword(email: email, password: password);
      state = AuthState.withUser(cred.user);
      return cred.user;
    } catch (e) {
      state = AuthState.withError(e.toString());
    }
  }

  authChanged(User? user) {
    if (user == null) {
      state = AuthState.withUser(null);
    }
  }
}

class AuthState {
  User? user;
  bool isLoading;
  String? error;

  AuthState({this.user, required this.isLoading, this.error});

  bool get loggedIn {
    return user != null;
  }

  bool get hasError {
    return error?.isNotEmpty ?? false;
  }

  factory AuthState.withUser(User? user) {
    return AuthState(user: user, isLoading: false, error: "");
  }

  factory AuthState.withLoading(bool isLoading) {
    return AuthState(isLoading: isLoading, error: "");
  }

  factory AuthState.withError(String error) {
    return AuthState(isLoading: false, error: error);
  }
}
