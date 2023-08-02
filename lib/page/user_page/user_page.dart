import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:event/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../services/api.dart';
import '../event_widget/container/my_container.dart';


/// Page displaying the summary of the events to which a user is subscribed as
/// both host and guest.
class UserPage extends StatefulWidget {
	UserPage({super.key});

	@override
	State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
	final _calendarFormat = CalendarFormat.month;
	var _selectedDay = DateTime.now();
	var _focusedDay = DateTime.now();

	FirebaseFirestore db = FirebaseFirestore.instance;
	Map events = <DateTime, Map<String, dynamic>>{};
	List _selectedEvents = [];


	Widget banner = CarouselSlider(
		options: CarouselOptions(
			aspectRatio: 16/9,
			enableInfiniteScroll: false,
			enlargeCenterPage: false,
			scrollDirection: Axis.horizontal,
		),
		items: [const MyContainer(
						title: 'Festival di SanRemo!',
						subtitle: "Partecipa all'evento della musica Italiana",
						date: '16/09/2023',
						),].map((i) {
			return Builder(
				builder: (BuildContext context) {
					return Container(
						// width: MediaQuery.of(context).size.width,
							margin: const EdgeInsets.symmetric(horizontal: 5.0),
							decoration: const BoxDecoration(
									color: Colors.white24
							),
							child: i,
					);
				},
			);
		}).toList(),
	);

	/// Returns the (eventually empty) list of events of a given day.
	List _getEventsForDay(DateTime day) {
		db.collection('events')
			.where('event_date', isEqualTo: day)
			//.where('guests.id', isEqualTo: Api().getCurrentUser())
			.get().then(
				(querySnapshot) {
					print("[getEventsForDay] ${querySnapshot.docs}");
					Map<String, dynamic> data;

					for (var docSnapshot in querySnapshot.docs) {
						data = docSnapshot.data();
						events[data['event_date']] = data;
					}
				},
			onError: (e) => print("Error completing: $e"),
		);

		return events[day] ?? [];
	}

	void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
		if (!isSameDay(_selectedDay, selectedDay)) {
			setState(() {
				_focusedDay = focusedDay;
				_selectedDay = selectedDay;
				_selectedEvents = _getEventsForDay(selectedDay);
			});
		}
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
					onDaySelected: _onDaySelected,
					onPageChanged: (focusedDay) {
						_focusedDay = focusedDay;
					},
					eventLoader: (day) {
						return _getEventsForDay(day);
					},
				),
				const Padding(
				  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
				  child: Text(
				  	'Host Events',
				  	style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
				  ),
				),
				banner,
				const Padding(
					padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
					child: Text(
						'Guest Events',
						style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
					),
				),
				banner,
			],
		);
	}
}