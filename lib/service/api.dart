import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class Api {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Api();

  void printTest() {
    print('data');
  }
}