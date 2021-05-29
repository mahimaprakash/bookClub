import 'package:cloud_firestore/cloud_firestore.dart';

class MyBook {
  String id;
  String name;
  String author;
  int length;
  DateTime dateCompleted;

  MyBook({this.id, this.name, this.author, this.length, this.dateCompleted});
}
