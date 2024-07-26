import 'package:bloc_fb_auth/auth/bloc/auth_cubit.dart';
import 'package:bloc_fb_auth/auth/bloc/auth_state.dart';
import 'package:bloc_fb_auth/auth/repo/auth_repo.dart';
import 'package:bloc_fb_auth/auth/ui/auth_screen.dart';
import 'package:bloc_fb_auth/auth/ui/home_screen.dart';
import 'package:bloc_fb_auth/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(BlocAuthFbApp());
}

class BlocAuthFbApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();

  BlocAuthFbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(FirebaseAuth.instance, authRepository, AuthInitial()),
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/auth": (context) => const AuthScreen(),
        },
        title: 'Flutter Bloc Auth',
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
