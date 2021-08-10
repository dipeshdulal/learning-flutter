import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rnd/models/auth_state/auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  return AuthService(ref: ref);
});

class AuthService extends StateNotifier<AuthState> {
  ProviderRefBase ref;

  AuthService({required this.ref}) : super(AuthState.initial());

  Stream<User?> get authState =>
      this.ref.read(firebaseAuthProvider).authStateChanges();

  registerUser({String email = "", String password = ""}) async {
    try {
      state = const AuthState.loading();
      UserCredential cred = await this
          .ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      state = AuthState.user(cred.user);
      return cred.user;
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  signOut() async {
    await this.ref.read(firebaseAuthProvider).signOut();
  }

  signIn({String email = "", String password = ""}) async {
    try {
      state = const AuthState.loading();
      UserCredential cred = await this
          .ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      state = AuthState.user(cred.user);
      return cred.user;
    } catch (e) {
      state = AuthState.error(e.toString());
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

        state = AuthState.user(userCreds.user);
        return null;
      }
      throw new Exception("error signing in ...");
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
