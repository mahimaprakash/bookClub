import 'package:cloud_firestore/cloud_firestore.dart';

class MyBook {
  String id;
  String name;
  int length;
  Timestamp dateCompleted;

  MyBook({this.id, this.name, this.length, this.dateCompleted});
}
