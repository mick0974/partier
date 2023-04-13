import 'package:flutter/material.dart';

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
	bool create = false;

	/// According to button's selcted boolean value changes the displayed page.
	void switchPage() {
		setState(() {
			//...	
		});
	}
	
	@override
	Widget build(BuildContext context) {

		return Scaffold(
			body: explore
				? const Center(child: Text('This is the home page for Explore'),) // qui ci va il richiamo alla classe principale dewl file discover_page.dart
				: const Center(child: Text('This is the home page for Create'),), // qui il link per la create_page.dart
			bottomNavigationBar: BottomAppBar(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: <Widget>[
						FilledButton.icon(
							onPressed: () {ScaffoldMessenger.of(context).showSnackBar(
									const SnackBar(content: Text('Switch to explore mode.'),
									duration: Duration(milliseconds: 1000)));
									setState(() {
										explore = true;
										create = false;
									});
								},
							label: const Text('Explore'),
							icon: const Icon(Icons.map_outlined),
							style: explore
									? ElevatedButton.styleFrom(
										// minimumSize: const Size.fromHeight(1),
										padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.5),
							)
									: ElevatedButton.styleFrom(
										primary: Colors.black26,
										padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.5),
									),
						),
						FilledButton.icon(
							onPressed: () => {ScaffoldMessenger.of(context).showSnackBar(
									const SnackBar(content: Text('Switch to host mode.'),
											duration: Duration(milliseconds: 1000))),
									setState(() {
										create = true;
										explore = false;
									})
								},
							label: const Text('Create'),
							icon: const Icon(Icons.event_available_rounded),
							style: create
									? ElevatedButton.styleFrom(
								padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.3),
							)
									: ElevatedButton.styleFrom(
								primary: Colors.black26,
								padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.shortestSide/6.3),
							),
						),
					],
				),
			),
		);
	}
}