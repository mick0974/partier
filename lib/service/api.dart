import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class Api {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Api();

  Future<void> addEvent() async {
    final event = <String, dynamic>{
      "name_event": "Festa",
      "place": GeoPoint(1, 1),
      "public": true
    };

    await db.collection("events").add(event);
  }

  Future<void> printTest() async {
    await db.collection("events").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
