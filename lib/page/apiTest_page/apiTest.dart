import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:geocoding/geocoding.dart';

import '../../services/api.dart';
import '../../services/auth_service.dart';

class ApiTestPage extends StatefulWidget {
  final String title = 'Partier';

  const ApiTestPage({super.key});

  @override
  State<ApiTestPage> createState() => _ApiTestPage();
}

class _ApiTestPage extends State<ApiTestPage> {
  final textController = TextEditingController();
  Api api = Api();

  void _launchMaps(double lat, double lng) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(lat, lng),
      title: "Ocean Beach",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: textController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nome evento',
              ),
            ),
          ),
          Center (
            child: ElevatedButton(
            onPressed: () {
              _launchMaps(43.12009522992823, 12.132218131394184);
            },
            child: Text("Test maps"),
          ),
          ),
          Center (
            child: ElevatedButton(
              onPressed: () {
                signOut();
              },
              child: Text("Sign out"),
            ),
          ),
        ],
      )
    );
  }
}
