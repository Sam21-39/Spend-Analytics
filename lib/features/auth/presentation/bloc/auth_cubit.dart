import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/auth/domain/usecases/sign_in_anonymously_use_case.dart';
import 'package:spend_analytics/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:spend_analytics/features/auth/domain/usecases/link_google_account_use_case.dart';
import 'package:spend_analytics/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:spend_analytics/features/auth/domain/usecases/watch_auth_state_use_case.dart';
import 'package:spend_analytics/features/auth/domain/entities/user_entity.dart';

import 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._watchAuthState,
    this._signInWithGoogle,
    this._signInAnonymously,
    this._linkGoogleAccount,
    this._signOut,
  ) : super(const AuthState.initial());

  final WatchAuthStateUseCase _watchAuthState;
  final SignInWithGoogleUseCase _signInWithGoogle;
  final SignInAnonymouslyUseCase _signInAnonymously;
  final LinkGoogleAccountUseCase _linkGoogleAccount;
  final SignOutUseCase _signOut;

  StreamSubscription<UserEntity?>? _authSub;

  void startWatching() {
    _authSub?.cancel();
    _authSub = _watchAuthState().listen((userOrNull) {
      if (isClosed) return;
      if (userOrNull == null) {
        emit(const AuthState.unauthenticated());
      } else if (userOrNull.isAnonymous) {
        emit(AuthState.anonymous(uid: userOrNull.uid));
      } else {
        emit(AuthState.authenticated(user: userOrNull));
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthState.loading());
    final result = await _signInWithGoogle();
    result.fold(
      (f) => emit(AuthState.failure(failure: f)),
      (user) => emit(
        user.isAnonymous
            ? AuthState.anonymous(uid: user.uid)
            : AuthState.authenticated(user: user),
      ),
    );
  }

  Future<void> signInAnonymously() async {
    emit(const AuthState.loading());
    final result = await _signInAnonymously();
    result.fold(
      (f) => emit(AuthState.failure(failure: f)),
      (user) => emit(AuthState.anonymous(uid: user.uid)),
    );
  }

  Future<void> linkGoogleAccount() async {
    emit(const AuthState.loading());
    final result = await _linkGoogleAccount();
    result.fold(
      (f) => emit(AuthState.failure(failure: f)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> signOut() async {
    emit(const AuthState.loading());
    final result = await _signOut();
    result.fold(
      (f) => emit(AuthState.failure(failure: f)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  /// Returns the active user ID for use in repository calls.
  /// Falls back to 'guest' before auth resolves.
  String resolveActiveUserId() => state.maybeMap(
        authenticated: (s) => s.user.uid,
        anonymous: (s) => s.uid,
        orElse: () => 'guest',
      );

  UserEntity? get currentUser => state.mapOrNull(
        authenticated: (s) => s.user,
      );

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
