import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:partier/page/login_page/login_page.dart';
import 'firebase_options.dart';
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
			home: StreamBuilder<User?>(
				stream: FirebaseAuth.instance.authStateChanges(),
				builder: (BuildContext context, AsyncSnapshot snapshot){
					if(snapshot.hasError)
					{
						return Text(snapshot.error.toString());
					}

					if(snapshot.connectionState == ConnectionState.active)
						{
							print(snapshot.data);
							if(snapshot.data == null)
								{
									return LoginPage();
								}
							else
								{
									return HomePage();
								}
						}

					return Text("Error");
				},
			)
		);
	}
}