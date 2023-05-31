import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Api();

  Future<void> addEvent() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final event = <String, dynamic>{
      "name_event": "Quando mia nonna non c'è",
      "description": "I topi ballano",
      "owner": auth.currentUser!.uid.toString(),
      "creation_date": DateTime.now(),
      "event_date": DateTime.now(),
      "place": GeoPoint(2, 2),
      "public": true
    };

    await db.collection("events").add(event);
    print(db.collection("events").add(event));

  }

  Future<void> printTest() async {
    await db.collection("events").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
