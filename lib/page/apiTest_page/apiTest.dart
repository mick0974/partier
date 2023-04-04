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
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    api.printTest();

    return Scaffold();
  }
}