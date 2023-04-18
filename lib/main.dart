import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;

import 'home_page.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp();

	runApp(const Partier());
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
	const Partier({super.key});

	@override
	Widget build(BuildContext context) {
		// Comando per impedire alla visualizzazione dell'app di
		// ruotare quando si ruota lo schermo
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
		]);
		return MaterialApp(
			title: 'Partier',
			theme: ThemeData(
				primarySwatch: Colors.teal,
			),
			home: const HomePage(),
		);
	}
}