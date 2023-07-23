import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class Event {
  static final String columnId = "_id";
  static final String columnNameEvent = "name_event";
  static final String columnCreationDate = "creation_date";
  static final String columnDescription = "description";
  static final String columnDressCode = "dress_code";
  static final String columnEventDate = "event_date";
  static final String columnOwner = "owner";
  static final String columnPlace = "place";
  static final String columnPublic = "public";

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