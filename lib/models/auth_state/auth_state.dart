import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "auth_state.freezed.dart";

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthStateInitial;
  const factory AuthState.user(User? user) = AuthStateUser;
  const factory AuthState.loading() = AuthStateLoading;
  const factory AuthState.error(String? error) = AuthStateError;
}
