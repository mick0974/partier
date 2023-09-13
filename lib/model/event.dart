import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

// TODO: add participants
class Event {
  static const String columnId = "_id";
  static const String columnNameEvent = "name_event";
  static const String columnCreationDate = "creation_date";
  static const String columnDescription = "description";
  static const String columnDressCode = "dress_code";
  static const String columnEventDate = "event_date";
  static const String columnOwner = "owner";
  static const String columnPlace = "place";
  static const String columnPublic = "public";

  Event({
    required this.id,
    required this.nameEvent,
    required this.eventDate,
    this.description,
    this.dressCode,
    this.creationDate,
    this.place,
    this.owner,
    this.public
  });

  final String? id;
  final String nameEvent;
  final DateTime eventDate;
  final String? description;
  final String? dressCode;
  final DateTime? creationDate;
  final GeoPoint? place;
  final String? owner;
  final bool? public;

  @override
  String toString() {
    late String event;

    event = 'Event $id: \n'
            '- Name: $nameEvent; \n'
            '- Date: $eventDate; \n';

    return event;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      columnNameEvent: nameEvent,
      columnCreationDate: creationDate,
      columnDescription: description,
      columnDressCode: dressCode,
      columnEventDate: eventDate,
      columnPlace: place,
      columnOwner: owner,
      columnPublic: public
    };

    return map;
  }

  /*
  // TODO: consider to implement these
  factory City.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return City(
      name: data?['name'],
      state: data?['state'],
      country: data?['country'],
      capital: data?['capital'],
      population: data?['population'],
      regions:
      data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (capital != null) "capital": capital,
      if (population != null) "population": population,
      if (regions != null) "regions": regions,
    };
  }
   */

  /*
  static AustinFeedsMeEvent fromMap(Map map) {
    return new AustinFeedsMeEvent(
        name: map[columnName],
        time: map[columnTime],
        description: map[columnDescription],
        url: map[columnUrl],
        photoUrl: map[columnPhotoUrl],
        latLng: new LatLng(map[columnLat], map[columnLng]));
  }
   */
}