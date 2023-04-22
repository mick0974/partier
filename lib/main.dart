import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;
import 'package:go_router/go_router.dart';
import 'package:partier/page/apiTest_page/apiTest.dart';
import 'package:partier/page/discover_page/discover_page.dart';
import 'package:partier/routing/app_router.dart';

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

	final GoRouter _router = AppRouter().router;

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