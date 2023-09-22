import 'dart:collection';

//import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../event_widget/container/my_container.dart';
import 'package:partier/model/event.dart';


/// Page displaying the summary of the events to which a user is subscribed as
/// both host and guest.
class UserPage extends StatefulWidget {
	UserPage({super.key});

	@override
	State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
	//final _dateFormat = DateFormat('d/M/y');
	final _calendarFormat = CalendarFormat.month;

	late ValueNotifier<List<Event>> _selectedEvents;
	DateTime _focusedDay = DateTime.now();
	DateTime? _selectedDay;

	// TODO: filter through participants
	final Stream<QuerySnapshot> _eventsStream =
		FirebaseFirestore.instance.collection('events')
			.where("event_date", isGreaterThan: DateTime.now())
			.snapshots();

	var _events = LinkedHashMap<DateTime, List<Event>>(equals: isSameDay);

	// TODO: Not efficient, doesn't remove if not found, always adds
	void addEvents(AsyncSnapshot<QuerySnapshot> snapshot) {
		DateTime eventDate;
		Event event;

		// Retrieving data from Firestore
		List<Event> tmp = snapshot.data!.docs.map((DocumentSnapshot doc) {
			Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

			return Event(
				id: doc.id,
				nameEvent: data['name_event'],
				eventDate: data['event_date'].toDate(),
				owner: data['owner'],
			);
		})
		.toList()
		.cast();

		// Filling _events
		for(event in tmp) {
			eventDate = event.eventDate;

			if(_events[eventDate] == null) {
				_events[eventDate] = [event];
			} else {
				_events[eventDate]!.add(event);
			}
		}

		print('[addEvents] events: ${_events.keys}');
	}

	/*
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
	 */

	/// Returns the (eventually empty) list of events of a given day.
	List<Event> _getEventsForDay(DateTime day) {
		return _events[day] ?? [];
	}

	void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
		if (!isSameDay(_selectedDay, selectedDay)) {
			setState(() {
				_focusedDay = focusedDay;
				_selectedDay = selectedDay;
			});

			_selectedEvents.value = _getEventsForDay(selectedDay);
		}
	}

	@override
	void initState() {
		super.initState();

		_selectedDay = _focusedDay;
		_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
	}

	@override
	void dispose() {
		_selectedEvents.dispose();

		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return StreamBuilder<QuerySnapshot>(
			stream: _eventsStream,
			builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
				Widget disc;

				if (snapshot.hasError) {
					disc = const Text('Something went wrong');
				} else if (snapshot.connectionState == ConnectionState.waiting) {
					disc = const Text("Loading");
				} else {
					addEvents(snapshot);

					disc = ListView(
						padding: const EdgeInsets.all(8),
						children: <Widget>[
							TableCalendar(
								firstDay: DateTime(2006),
								lastDay: DateTime(2036),
								focusedDay: _focusedDay,
								selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
								calendarFormat: _calendarFormat,
								eventLoader: _getEventsForDay,
								onDaySelected: _onDaySelected,
								onPageChanged: (focusedDay) {
									_focusedDay = focusedDay;
								},
							),
							const Padding(
								padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
								child: Text(
									'Host Events',
									style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
								),
							),
							//banner,
							const Padding(
								padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
								child: Text(
									'Guest Events',
									style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
								),
							),
							//banner,
						],
					);
				}

				return disc;
			}
		);
	}
}