import 'package:cloud_firestore/cloud_firestore.dart';

class MyGroup {
  String id;
  String name;
  String leader;
  List<String> members;
  Timestamp groupCreated;

  MyGroup({this.id, this.name, this.leader, this.members, this.groupCreated});
}
