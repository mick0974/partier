import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;
import 'package:go_router/go_router.dart';
import 'package:partier/page/apiTest_page/apiTest.dart';
import 'package:partier/page/discover_page/discover_page.dart';

import 'firebase_options.dart';
import 'home_page.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);

	runApp(Partier());
}

/// Generates an instance of the applicaztion having HomePage as home page
/*
* To Be Done:
* - Remove degub band;
* - Make adaptive to dark theme;
* - Properly setup theme;
* - Set adaptive theme for Android;
*/
class Partier extends StatelessWidget {
	Partier({super.key});

	final GoRouter _router = GoRouter(
		//errorBuilder: (context, state) => ErrorScreen(error:state.error),
		routes: <GoRoute>[
			GoRoute(
				routes: <GoRoute>[
					GoRoute(
						path: 'home',
						builder: (BuildContext context, GoRouterState state) =>
						const HomePage(),
					),
					GoRoute(
						path: 'events',
						builder: (BuildContext context, GoRouterState state) =>
						const DiscoverPage(),
					),
					GoRoute(
						path: 'create_event',
						builder: (BuildContext context, GoRouterState state) =>
						const ApiTestPage(),
					),
					GoRoute(
						path: 'events/:eventId',
						builder: (BuildContext context, GoRouterState state) =>
						const ApiTestPage(),
					),
				],
				path: '/',
				builder: (BuildContext context, GoRouterState state) =>
				const HomePage(),
			),
		],

	);

	@override
	Widget build(BuildContext context) {
		// Comando per impedire alla visualizzazione dell'app di
		// ruotare quando si ruota lo schermo
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
		]);
		return MaterialApp.router(
			title: 'Partier',
			theme: ThemeData(
				primarySwatch: Colors.teal,
			),
			routerDelegate: _router.routerDelegate,
			routeInformationParser: _router.routeInformationParser,
			routeInformationProvider: _router.routeInformationProvider,
		);
	}
}