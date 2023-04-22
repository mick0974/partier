import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home_page.dart';
import '../page/discover_page/discover_page.dart';
import '../services/app_service.dart';
import '../services/auth_service.dart';

class AppRouter {
  final AuthService authService;
  final AppService? appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService, this.authService);

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
        path: VIEW.createEvent.toPath,
        name: VIEW.createEvent.toName,
        builder: (context, state) => const ApiTestPage(),
        redirect: (context, state) => _redirect(context),
      ),
    ],
    //errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
  );

  String? _redirect(context) {
      var isAuthenticated = authService.checkIfLogged();
      print("LOLLO");
      print(isAuthenticated);
      if (isAuthenticated == null) {
        return '/login';
      } else {
        return null; // return "null" to display the intended route without redirecting
      }
  }


}