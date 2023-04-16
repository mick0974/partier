import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/api.dart';

class ApiTestPage extends StatefulWidget {
  final String title = 'Partier';

  const ApiTestPage({super.key});

  @override
  State<ApiTestPage> createState() => _ApiTestPage();
}

class _ApiTestPage extends State<ApiTestPage> {
  final textController = TextEditingController();
  Api api = Api();

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
        ],
      )
    );
  }
}
