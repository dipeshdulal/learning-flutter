import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  return AuthService(ref: ref);
});

class AuthService extends StateNotifier<AuthState> {
  ProviderRefBase ref;

  AuthService({required this.ref}) : super(AuthState(isLoading: false)) {
    this.ref.read(firebaseAuthProvider).authStateChanges().listen((User? user) {
      state = AuthState.withUser(user);
    });
  }

  registerUser({String email = "", String password = ""}) async {
    try {
      state = AuthState.withLoading(true);
      UserCredential cred = await this
          .ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      state = AuthState.withUser(cred.user);
      return cred.user;
    } catch (e) {
      state = AuthState.withError(e.toString());
    }
  }

  signOut() async {
    await this.ref.read(firebaseAuthProvider).signOut();
  }

  signIn({String email = "", String password = ""}) async {
    try {
      state = AuthState.withLoading(true);
      UserCredential cred = await this
          .ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      state = AuthState.withUser(cred.user);
      return cred.user;
    } catch (e) {
      state = AuthState.withError(e.toString());
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final creds = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCreds = await this
            .ref
            .read(firebaseAuthProvider)
            .signInWithCredential(creds);

        state = AuthState.withUser(userCreds.user);
        return null;
      }
      throw new Exception("error signing in ...");
    } catch (e) {
      state = AuthState.withError(e.toString());
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
