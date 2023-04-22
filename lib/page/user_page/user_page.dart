import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:event/event.dart';
import 'package:table_calendar/table_calendar.dart';
import '../event_widget/container/my_fancy_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../event_widget/container/my_container.dart';


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


	Widget banner = CarouselSlider(
		options: CarouselOptions(
			aspectRatio: 16/9,
			enableInfiniteScroll: false,
			autoPlay: false,
			autoPlayInterval: Duration(seconds: 2),
			autoPlayAnimationDuration: Duration(milliseconds: 800),
			autoPlayCurve: Curves.fastOutSlowIn,
			enlargeCenterPage: false,
			enlargeFactor: 0.0,
			scrollDirection: Axis.horizontal,
		),
		items: [MyContainer(
						title: 'Festival di SanRemo!',
						subtitle: "Partecipa all'evento della musica Italiana",
						space_for_button: ''
						),
						MyContainer(
								title: 'Fake News!',
								subtitle: "La Band più attesa negli stadi",
								space_for_button: '',
								image_path: 'assets/images/pinguini.jpg',
						),
						MyContainer(
							title: 'Will of the People!',
							subtitle: "L'evento di Rock Alternativo dell'anno!",
							space_for_button: '',
							image_path: 'assets/images/muse.png',
						)].map((i) {
			return Builder(
				builder: (BuildContext context) {
					return Container(
						// width: MediaQuery.of(context).size.width,
							margin: EdgeInsets.symmetric(horizontal: 5.0),
							decoration: BoxDecoration(
									color: Colors.white24
							),
							child: i,
					);
				},
			);
		}).toList(),
	);

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
				Container(
					height: 15,
				),
				Text('My Events', style: TextStyle(fontWeight: FontWeight.bold,
				fontSize: 20),),
				Container(
					height: 15,
				),
				banner,
			],
		);
	}
}