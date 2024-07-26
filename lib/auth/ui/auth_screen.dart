import 'package:bloc_fb_auth/auth/bloc/auth_cubit.dart';
import 'package:bloc_fb_auth/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator();
        } else if (state is Authenticated) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    Text(state.email),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AuthCubit>().signOut(context),
                      child: const Text("Ausloggen"),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is Unauthenticated) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nicht authentifiziert"),
                  ],
                ),
              ),
            ),
          );
        } else if (state is AuthRequest) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        "Ein unbekannter Fehler ist aufgetreten, versuche dich noch einmal anzumelden"),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Zur Welcome Page zurückkehren"),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
