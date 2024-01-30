import 'package:bloc_fb_auth/bloc_example/auth/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/auth_repo.dart';

/// [AuthCubit]-Klasse, die von [Cubit<AuthState>] erbt
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _firebaseAuth;

  /// Konstruktor für die AuthCubit-Klasse
  AuthCubit(this._firebaseAuth, this._authRepository, super.initialState);

  /// Methode zum Anmelden mit Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      emit(AuthLoading());
      await _authRepository.loginWithGoogle();

      emit(Authenticated(
        "Success",
        _authRepository.getCurrentUser()!.email.toString(),
      ));
      if (context.mounted) Navigator.popAndPushNamed(context, "/auth");
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    final appleProvider = AppleAuthProvider();
    try {
      await _firebaseAuth.signInWithProvider(appleProvider);
      emit(Authenticated(
        "Success",
        _authRepository.getCurrentUser()!.email.toString(),
      ));
      if (context.mounted) Navigator.popAndPushNamed(context, "/auth");
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Methode zum Anmelden mit E-Mail und Passwort
  Future<void> loginWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      emit(AuthLoading());
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(
        Authenticated(
          "Success",
          userCredential.user!.email.toString(),
        ),
      );
      if (context.mounted) Navigator.pushNamed(context, "/auth");
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Methode zum Abmelden
  Future<void> signOut(BuildContext context) async {
    await _authRepository.signOut();
    emit(Unauthenticated());
    if (context.mounted) Navigator.popAndPushNamed(context, "/");
  }
}
