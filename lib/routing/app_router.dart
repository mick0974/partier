import 'package:go_router/go_router.dart';
import 'package:partier/page/login_page/login_page.dart';
import 'package:partier/services/auth_service.dart';

import '../home_page.dart';
import '../page/apiTest_page/apiTest.dart';
import '../page/discover_page/discover_page.dart';


class AppRouter {
  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        routes: <GoRoute>[
          GoRoute(
            path: "home",
            name: "HOME",
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: "events",
            name: "EVENTS",
            builder: (context, state) => const DiscoverPage(),
          ),
          GoRoute(
            path: "create-event",
            name: "CREATE-EVENT",
            builder: (context, state) => const ApiTestPage(),
            redirect: (context, state) => _redirect(context),
          ),
          GoRoute(
            path: "login",
            name: "LOGIN",
            builder: (context, state) => const LoginPage(),
          ),
        ],
        path: '/',
        builder: (context, GoRouterState state) =>
        const HomePage(),
      )
    ]
  );

  String? _redirect(context) {
      var isAuthenticated = checkIfLoggedIn();

      if (isAuthenticated == null) {
        return '/login';
      } else {
        return null; // return "null" to display the intended route without redirecting
      }
  }


}