import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // 1
  final LoginState loginState;
  AppRouter(this.loginState);

  // 2
  late final router = GoRouter(
    // 3
    refreshListenable: loginState,
    // 4
    debugLogDiagnostics: true,
    // 5
    urlPathStrategy: UrlPathStrategy.path,

    // 6
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (state) =>
        // TODO: Change to Home Route
        state.namedLocation(loginRouteName),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const Login(),
        ),
      ),
      GoRoute(
        name: createAccountRouteName,
        path: '/create-account',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const CreateAccount(),
        ),
      ),
    ],
    // TODO: Add Error Handler
    // TODO Add Redirect
  );



}