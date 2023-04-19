import 'package:flutter/material.dart';
import '../event_widget/container/my_fancy_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import '../apiTest_page/apiTest.dart';



/// Home page of the application.
/// This widget will contain an upper bar and an istance of page widget. In
/// particular, through a button will get access to the user's options.
class CreatePage extends StatefulWidget {
  final String title = 'Partier';

  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePage();
}


class _CreatePage extends State<CreatePage> {


  Widget imageProfile() {
    return Center(
      child: Column(
        children: [Stack(
          children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage("assets/images/new-event.png"),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
          ]
        ),
        Container(
          alignment: Alignment.centerLeft,
        child: Text('Nome Evento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
          TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Inserisci il nome dell'evento",
          ),
        ),
          Container(
            height: 40,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
                children: [
                  Text('Luogo Evento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  IconButton(
                    color: Colors.teal,
                      onPressed: () {setState(() {
                        context.go('/create_event');
                      });}, icon: Icon(Icons.location_pin)
                  ),]
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Inserisci il luogo dell'evento",
          ),
        ),

          // Container(
          //   alignment: Alignment.centerLeft,
          //   child: Text('Nome Evento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          // ),
          // TextFormField(
          //   decoration: const InputDecoration(
          //     border: UnderlineInputBorder(),
          //     labelText: "Inserisci il nome dell'evento",
          //   ),
          // ),
      ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      body: Form(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: <Widget>[
            imageProfile(),
        SizedBox(
          height: 20,
        ),
      ]
        ),
    )
    );


  }
}