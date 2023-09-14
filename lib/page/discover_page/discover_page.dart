import 'dart:math';

import 'package:flutter/material.dart';
import 'package:partier/services/auth_service.dart';
import '../event_widget/container/my_fancy_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partier/services/api.dart';


/// Home page of the application.
/// This widget will contain an upper bar and an istance of page widget. In
/// particular, through a button will get access to the user's options.
class DiscoverPage extends StatefulWidget {
  final String title = 'Partier';

  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPage();
}

class _DiscoverPage extends State<DiscoverPage> {
  var api = Api();
  var loginInfo = LoginInfo();  /// TODO: Not saving login info

  late Future<List> events;
  List<Widget> eventContainers = [];
  bool firstUpdate = true;
  int counter = 0;

  /// What do we need reset and firstUpdate?
  Future<List> updateEventsList({bool reset = true}) async {
    List tmp = [];

    //https://firebase.google.com/docs/firestore/query-data/get-data
    counter++;

    if(reset) counter = 0;
    firstUpdate = !(counter > 1);

    CollectionReference ref = FirebaseFirestore.instance.collection('events');

    QuerySnapshot eventsQuery = await ref
      .where("public", isEqualTo: true)
      .where("event_date", isGreaterThan: DateTime.now())
      .get();

    for (var doc in eventsQuery.docs) {
      tmp.add({doc.id: doc.data()});
    }

    return tmp;
  }

  void createEventContainers(List ev) {
    eventContainers = [];

    for (var i = 0; i < min(ev.length, 3); i++) {
      var tmpId = ev[i].keys.toList()[0];
      var tmp = ev[i].values.toList()[0];
      var date = DateTime.fromMillisecondsSinceEpoch(tmp["event_date"].seconds * 1000);

      eventContainers.add(
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.25,
              child: MyFancyContainer(
                id: tmpId,
                title: tmp["name_event"],
                date: "${date.day}-${date.month}-${date.year}",
              )
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if(firstUpdate) events = updateEventsList(reset: false);
  }

  @override
  Widget build(BuildContext context) {
    //if(firstUpdate) updateEventsList(reset: false);
    const Key centerKey = ValueKey<String>('bottom-sliver-list');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(
        future: events,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.data != null) {
            print('[Discover] ${snapshot.data}');
            if (firstUpdate) createEventContainers(snapshot.data!);
          } else {
            eventContainers.add(const Text('No event available.'));
          }

          return CustomScrollView(
            center: centerKey,
            slivers: <Widget>[
              SliverAppBar(
                flexibleSpace: SafeArea(
                    child: FilledButton.icon(
                      onPressed: () {
                        setState(() {
                          updateEventsList();
                          //createEventContainers(snapshot.data!);
                        });
                      },
                      icon: const Icon(Icons.update),
                      label: const Text('Tap to reload'),
                    )
                ),
              ),
              SliverList(
                key: centerKey,
                delegate: SliverChildListDelegate(
                  eventContainers,
                ),
              ),
            ],
          );
        },
      )
    );
  }
}