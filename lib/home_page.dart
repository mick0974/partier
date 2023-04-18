import 'package:flutter/material.dart';

import 'page/wrap_widget.dart';
import 'page/discover_page/discover_page.dart';

//import './bar/bar_widget.dart';

/// Home page of the application.
/// This widget will contain an upper bar and an istance of page widget. In
/// particular, through a button will get access to the user's options.
class HomePage extends StatefulWidget {
	final String title = 'Partier';

	const HomePage({super.key});

	@override
	State<HomePage> createState() => _HomePageState();
}

/// Defines the HomePage's layout and behaviour.
/// Every HomePage be Scaffold and will have:
/// * An AppBar containing title and IconButton (this last reidirecting to a
/// UserAccount widget);
/// * An instance of Page widget managing whether a DiscoverPage widget or a
/// UserPage widget should be displayed.
class _HomePageState extends State<HomePage> {
	bool explore = true;
	bool create = false;

	void Show_date_picker() {
		showDatePicker(context: context,
				initialDate: DateTime.now(),
				firstDate: DateTime(2006),
				lastDate: DateTime(2036)
		);
	}

	@override
	Widget build(BuildContext context) {
		// User-page button
		Widget userButton = IconButton(
			icon: const Icon(Icons.account_circle),
			iconSize: 35,
			tooltip: 'User page',
			onPressed: () {
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('Not yet implemented.')));
			},
		);


		Widget calendar = IconButton(
			icon: const Icon(Icons.calendar_month_outlined),
			iconSize: 35,
			tooltip: 'calendar',
			onPressed: Show_date_picker,
		);

		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				actions: <Widget>[calendar,userButton],
			),
			body: WrapWidget(),
		);
	}
}