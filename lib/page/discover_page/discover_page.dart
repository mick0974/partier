import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import '../event_widget/container/my_fancy_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partier/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';


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

  List events = [];
  List<Widget> event_containers = [];
  bool first_update = true;
  int counter = 0;



  void create_events_containers(List ev) {
    event_containers = [];
    for (var i = 0; i < min(ev.length,3); i++){
      var tmpId = ev[i].keys.toList()[0];
      var tmp = ev[i].values.toList()[0];
      var date = DateTime.fromMillisecondsSinceEpoch(tmp["event_date"].seconds * 1000);

      event_containers.add(
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

  void update_events_list({bool reset = true}) {
    this.counter++;
    if (reset) {
      this.counter = 0;
    }
    if (counter >= 2){
      this.first_update = false;
    }else{
      this.first_update = true;
    }
    List tmp = [];
    FirebaseFirestore.instance.collection("events").where("public",
        isEqualTo: true).where("event_date", isGreaterThan: DateTime.now()).get().then(
          (querySnapshot) {
            print("Successfully completed");
            this.events = [];
            for (var docSnapshot in querySnapshot.docs) {
              setState(() {
                this.events.add({docSnapshot.id: docSnapshot.data()});
              });
            }
          },
        onError: (e) => print("Error completing: $e"),
        );
    create_events_containers(this.events);
    print(" stampando la lunghezza dei container ${this.event_containers.length}");
    }



  Widget banner = CarouselSlider(
    options: CarouselOptions(
        aspectRatio: 16/9,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
    ),
    items: ['assets/images/muse.png', 'assets/images/pinguini.jpg',
      'assets/images/TOMORROWLAND.jpg'].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              // width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white24
              ),
              child: Image.asset('$i')
          );
        },
      );
    }).toList(),
  );


  @override
  Widget build(BuildContext context) {
    if (this.first_update){
    update_events_list(reset: false);}
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    print("Siamo nell'override ${this.events.length}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        toolbarHeight: 180,
        flexibleSpace: SafeArea(
          child: banner
        ),
      ),
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: SafeArea(
              child: FilledButton.icon(
                onPressed: update_events_list,
                icon: Icon(Icons.update),
                label: Text('Tap to reload'),
              )
            ),
          ),

          SliverList(
            key: centerKey,
            delegate: SliverChildListDelegate(
                event_containers,
                ),

            ),

          // SliverPadding(padding: EdgeInsets.all(5))
        ],
      ),
    );
  }
}