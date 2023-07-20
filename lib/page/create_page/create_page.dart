import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:partier/services/api.dart';

/// Create page of the application.
/// This page will allow a user to fill all the needed fields in order to create
/// a new event. The fields will be checked against already present events in
/// the database and eventually added to it.
/*
TO BE DONE
- Add participants invitations;
- Return error when it's not possible to add the event.
 */
class CreatePage extends StatelessWidget {
  CreatePage({super.key});

  final db = Api();
  final _formKey = GlobalKey<FormState>();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  late String eventName;
  String eventDescription = '';
  DateTime eventDate = DateTime.now();
  GeoPoint eventPlace = GeoPoint(0, 0);
  String eventDress = '';

  var nameController = TextEditingController();
  var descrController = TextEditingController();
  var dateController = TextEditingController();
  var placeController = TextEditingController();

  /// Allows to choose the date from a date picker instead of via keyboard.
  /// After having selected a date, assigns its value to eventDate and fills the
  /// corresponding field in the form.
  void setDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode()); //No keyboard

    eventDate = (await showDatePicker(
      context: context,
      initialDate: eventDate,
      firstDate: DateTime(2006),
      lastDate: DateTime(2036),
    ))!;

    dateController.text = formatter.format(eventDate);
  }

  /// Given a prediction on an autocompleted address, eventually saves the
  /// information in the eventPlace.
  void setPlace(String? query) async {
    if(query != null) {
      List<Location> addresses = await locationFromAddress(
          query, localeIdentifier: 'it');
      var place = addresses.first;

      print("Found (${place.latitude}, ${place.longitude})");

      eventPlace = GeoPoint(place.latitude, place.longitude);
    }
  }

  /// Attempts to add an event in the database.
  /// After having retrieved the fields from the form, verifies whether or not
  /// they are compatible with already existing events. Then either adds a new
  /// event to the database or raises errors in the corresponding fields.
  /*
  TO BE IMPLEMENTED:
  - Check on events in database
   */
  void tryAddEvent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      db.addEvent(eventName, eventDress, eventDescription, eventDate, eventPlace);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added a party!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred, retry.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');

    return Scaffold(
        body: Form(
          child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Create Event',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Event's name",
                        ),
                        validator: (String? value) {
                          String? error;

                          if (value == null || value.isEmpty) {
                            error = 'Empty field not allowed.';
                          } else {
                            eventName = value;
                          }

                          return error;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Event's Dress code",
                        ),
                        validator: (String? value) {
                          String? error;

                          if (value == null || value.isEmpty) {
                            error = 'Empty field not allowed.';
                          } else {
                            eventDress = value;
                          }

                          return error;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Event's description",
                        ),
                        validator: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            eventDescription = value;
                          }
                        },
                      ),
                      TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: "Event's date",
                        ),
                        validator: (String? value) {
                          String? error;

                          if (value == null || value.isEmpty) {
                            error = 'Empty field not allowed.';
                          } else {
                            eventDate = formatter.parse(value);
                          }

                          return error;
                        },
                        onTap: () => setDate(context),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Event's location",
                        ),
                        validator: (String? value) {
                          String? error;

                          if (value == null || value.isEmpty) {
                            error = 'Empty field not allowed.';
                          } else {
                            setPlace(value);
                          }

                          return error;
                        },
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  label: const Text('Create!'),
                  icon: const Icon(Icons.celebration),
                  onPressed: () {
                    tryAddEvent(context);
                  },
                )
              ]
          ),
        )
    );
  }
}

/*
class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePage();
}

class _CreatePage extends State<CreatePage> {
  final db = Api();
  final _formKey = GlobalKey<FormState>();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  late String eventName;
  String eventDescription = '';
  DateTime eventDate = DateTime.now();
  GeoPoint eventPlace = GeoPoint(0, 0);
  String eventDress = '';

  var nameController = TextEditingController();
  var descrController = TextEditingController();
  var dateController = TextEditingController();
  var placeController = TextEditingController();

  /// Allows to choose the date from a date picker instead of via keyboard.
  /// After having selected a date, assigns its value to eventDate and fills the
  /// corresponding field in the form.
  void setDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode()); //No keyboard

    eventDate = (await showDatePicker(
      context: context,
      initialDate: eventDate,
      firstDate: DateTime(2006),
      lastDate: DateTime(2036),
    ))!;

    dateController.text = formatter.format(eventDate);
  }

  /// Given a prediction on an autocompleted address, eventually saves the
  /// information in the eventPlace.
  void setPlace(String? query) async {
    if(query != null) {
      List<Location> addresses = await locationFromAddress(
          query, localeIdentifier: 'it');
      var place = addresses.first;

      print("Found (${place.latitude}, ${place.longitude})");

      eventPlace = GeoPoint(place.latitude, place.longitude);
    }
  }

  /// Attempts to add an event in the database.
  /// After having retrieved the fields from the form, verifies whether or not
  /// they are compatible with already existing events. Then either adds a new
  /// event to the database or raises errors in the corresponding fields.
  /*
  TO BE IMPLEMENTED:
  - Check on events in database
   */
  void tryAddEvent() {
    if (_formKey.currentState!.validate()) {
      db.addEvent(eventName, eventDress, eventDescription, eventDate, eventPlace);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added a party!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred, retry.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Create Event',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Event's name",
                    ),
                    validator: (String? value) {
                      String? error;

                      if (value == null || value.isEmpty) {
                        error = 'Empty field not allowed.';
                      } else {
                        eventName = value;
                      }

                      return error;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Event's Dress code",
                    ),
                    validator: (String? value) {
                      String? error;

                      if (value == null || value.isEmpty) {
                        error = 'Empty field not allowed.';
                      } else {
                        eventDress = value;
                      }

                      return error;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Event's description",
                    ),
                    validator: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        eventDescription = value;
                      }
                    },
                  ),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: "Event's date",
                    ),
                    validator: (String? value) {
                      String? error;

                      if (value == null || value.isEmpty) {
                        error = 'Empty field not allowed.';
                      } else {
                        eventDate = formatter.parse(value);
                      }

                      return error;
                    },
                    onTap: () => setDate(context),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Event's location",
                    ),
                    validator: (String? value) {
                      String? error;

                      if (value == null || value.isEmpty) {
                        error = 'Empty field not allowed.';
                      } else {
                        setPlace(value);
                      }

                      return error;
                    },
                  ),
                ],
              ),
            ),
            TextButton.icon(
              label: const Text('Create!'),
              icon: const Icon(Icons.celebration),
              onPressed: tryAddEvent,
            )
          ]
        ),
      )
    );
  }
}
 */

/// Class for the text fields in the form.
// For the moment the check only evaluates if the string is empty/null and
// the outcome of the attempt of adding the field to the event.
// Consider also to define to pass to the constructor different functions
// depending on the text field (e.g. TextField(descriptor, bool validator()))
/*
class TextField extends TextFormField {
  static Widget getWidget(String descriptor) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Empty field is not allowed',
        labelText: descriptor,
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null) ? 'Empty string not allowed.' : null;
      },
    );
  }
}
*/