import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'apiTest_page/apiTest.dart';
import 'discover_page/discover_page.dart';
import 'user_page/user_page.dart';

//import './bar/bar_widget.dart';

/// Render page of the application.
/// This widget will contain a bottom bar (BarWidget) and an istance of page
/// widget (...).
class WrapWidget extends StatefulWidget {
	const WrapWidget({super.key});

	@override
	State<WrapWidget> createState() => _WrapWidgetState();
}

/// Defines the WrapWidget's layout and behaviour.
/// Every WrapWidget is a Scaffold and will have:
/// * A BottomAppBar containing buttons to redirect to a selected page;
/// * An instance of Page widget managing whether a DiscoverPage widget or a
/// UserPage widget should be displayed.
class _WrapWidgetState extends State<WrapWidget> {
	bool explore = true;
	bool events = false;
	bool central_b = false;
	
	@override
	Widget build(BuildContext context) {

		return Scaffold(
			body: explore
				? DiscoverPage() // qui ci va il richiamo alla classe principale dewl file discover_page.dart
				: events
				? UserPage()
				: const Center(child: Text('This is the home page for Create'),), // qui il link per la create_page.dart
			bottomNavigationBar: BottomAppBar(
				shape: const CircularNotchedRectangle(),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						Expanded(
							child:	FilledButton.icon(
											onPressed: () {setState(() {
														explore = true;
														events = false;
														central_b = false;
													});
												},
											label: const Text('Explore'),
											icon: explore
											? const Icon(Icons.map)
											: const Icon(Icons.map_outlined),
											style: explore
													? ElevatedButton.styleFrom(
														// minimumSize: const Size.fromHeight(1),
														// padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.5),
											)
													: ElevatedButton.styleFrom(
														primary: Colors.black26,
														// padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.5),
													),
										),
						),
						Container(width: 55, height: 1,),
						Expanded(
							child: FilledButton.icon(
										onPressed: () => {setState(() {
													events = true;
													explore = false;
													central_b = false;
												})
											},
										label: const Text('Events'),
										icon: events
												? const Icon(Icons.event_available)
												: const Icon(Icons.event_available_outlined),
										style: events
												? ElevatedButton.styleFrom(
											// padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.3),
										)
												: ElevatedButton.styleFrom(
											primary: Colors.black26,
											// padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.3),
										),
									),
						),
					],
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: () => {setState(() {
						explore = false;
						events = false;
						central_b = true;
						context.go('/create_event');
					})},
				backgroundColor: central_b
					? Colors.teal
					: Colors.black26,
				child: central_b
							? Icon(
								Icons.celebration,
								size: 30.0,
							)
							: Icon(
								Icons.celebration_outlined,
								size: 30.0,
								),
				shape: CircleBorder(),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
		);
	}
}