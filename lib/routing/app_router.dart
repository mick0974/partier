
import 'package:go_router/go_router.dart';
import 'package:partier/page/apiTest_page/apiTest.dart';
import 'package:partier/routing/route_utils.dart';

import '../home_page.dart';
import '../page/discover_page/discover_page.dart';
import '../services/app_service.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: VIEW.home.toPath,
    routes: <GoRoute>[
      GoRoute(
        path: VIEW.home.toPath,
        name: VIEW.home.toName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: VIEW.events.toPath,
        name: VIEW.events.toName,
        builder: (context, state) => const DiscoverPage(),
      ),
      GoRoute(
        path: VIEW.createEvent.toPath,
        name: VIEW.createEvent.toName,
        builder: (context, state) => const ApiTestPage(),
      ),
    ],
    //errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
    redirect: (context, state) {
      final createEventLocation = state.namedLocation(VIEW.createEvent.toName);
      final homeLocation = state.namedLocation(VIEW.home.toName);

      final isLogedIn = appService.loginState;
      final isInitialized = appService.initialized;
      final isOnboarded = appService.onboarding;

      final isGoingToCreateEvent = state.subloc == createEventLocation;

      print("--------------------------");
      print(state.location);
      print(state.subloc);
      print(createEventLocation);

      // If not Initialized and not going to Initialized redirect to Splash
      if (!isGoingToCreateEvent) {
        return createEventLocation;
      } else {
      // Else Don't do anything
        return null;
      }
    },
  );
}