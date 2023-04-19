import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:event/event.dart';
import 'package:table_calendar/table_calendar.dart';


/// Page displaying the summary of the events to which a user is subscribed as
/// both host and guest.
class UserPage extends StatefulWidget {
	Map events = LinkedHashMap<DateTime, List<Event<EventArgs>>>();
	
	UserPage({super.key});

	@override
	State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
	var _calendarFormat = CalendarFormat.month;
	var _selectedDay = DateTime.now();
	var _focusedDay = DateTime.now();

	/*
	void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
		if (!isSameDay(_selectedDay, selectedDay)) {
		setState(() {
		_focusedDay = focusedDay;
		_selectedDay = selectedDay;
		_selectedEvents = _getEventsForDay(selectedDay);
		});
		}
	}
	*/

	/// Returns the (eventually empty) list of events of a given day.
	List<Event> _getEventsForDay(UserPage widget, DateTime day) {
		return widget.events[day] ?? [];
	}

	@override
	Widget build(BuildContext context) {
		return ListView(
			padding: const EdgeInsets.all(8),
			children: <Widget>[
				TableCalendar(
					calendarFormat: _calendarFormat,
					firstDay: DateTime(2006),
					lastDay: DateTime(2036),
					focusedDay: _focusedDay,
					selectedDayPredicate: (day) {
						return isSameDay(_selectedDay, day);
					},
					onDaySelected: (selectedDay, focusedDay) {
						setState(() {
							_selectedDay = selectedDay;
							_focusedDay = focusedDay;
						});
					},
					onPageChanged: (focusedDay) {
						_focusedDay = focusedDay;
					},
					eventLoader: (day) {
						return _getEventsForDay(widget, day);
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