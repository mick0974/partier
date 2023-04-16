import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Page displaying the summary of the events to which a user is subscribed as
/// both host and guest.
class UserPage extends StatefulWidget {
	
	const UserPage({super.key});

	@override
	State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
	var _selectedDay = DateTime.now();
	var _focusedDay = DateTime.now();

	@override
	Widget build(BuildContext context) {
		return ListView(
			padding: const EdgeInsets.all(8),
			children: <Widget>[
				TableCalendar(
					firstDay: DateTime(2006),
					lastDay: DateTime(2036),
					focusedDay: _focusedDay,
					selectedDayPredicate: (day) {
						return isSameDay(_selectedDay, day);
					},
					onDaySelected: (selectedDay, focusedDay) {
						setState(() {
							_selectedDay = selectedDay;
							_focusedDay = focusedDay; // update `_focusedDay` here as well
						});
					},
				),
				Container(
					height: 50,
					color: Colors.amber[500],
					child: const Center(child: Text('Host Events')),
				),
				Container(
					height: 50,
					color: Colors.amber[100],
					child: const Center(child: Text('Guest Events')),
				),
			],
		);
	}
}