import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;
import 'package:go_router/go_router.dart';
import 'package:partier/page/apiTest_page/apiTest.dart';
import 'package:partier/page/discover_page/discover_page.dart';
import 'package:partier/routing/app_router.dart';
import 'package:partier/services/app_service.dart';
import 'package:partier/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'home_page.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);
	final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
	runApp(Partier(sharedPreferences: sharedPreferences));
}

class Partier extends StatefulWidget {
	final SharedPreferences sharedPreferences;
	const Partier({
		Key? key,
		required this.sharedPreferences,
	}) : super(key: key);

	@override
	_Partier createState() => _Partier();
}

class _Partier extends State<Partier> {
	late AppService appService;
	late AuthService authService;
	late StreamSubscription<bool> authSubscription;

	@override
	void initState() {
		appService = AppService(widget.sharedPreferences);
		authService = AuthService();
		authSubscription = authService.onAuthStateChange.listen(onAuthStateChange);
		super.initState();
	}

	void onAuthStateChange(bool login) {
		appService.loginState = login;
	}

	@override
	void dispose() {
		authSubscription.cancel();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		// Comando per impedire alla visualizzazione dell'app di
		// ruotare quando si ruota lo schermo
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
		]);
		return MultiProvider(
			providers: [
				ChangeNotifierProvider<AppService>(create: (_) => appService),
				Provider<AppRouter>(create: (_) => AppRouter(appService)),
				Provider<AuthService>(create: (_) => authService),
			],
			child: Builder(
				builder: (context) {
					final GoRouter goRouter = Provider.of<AppRouter>(context, listen: false).router;
					return MaterialApp.router(
						title: 'Partier',
						theme: ThemeData(
							primarySwatch: Colors.teal,
						),
						routeInformationParser: goRouter.routeInformationParser,
						routerDelegate: goRouter.routerDelegate,
					);
				},
			),
		);
	}
}
