import 'package:cloud_firestore/cloud_firestore.dart';

class MyGroup {
  String id;
  String name;
  String leader;
  List<String> members;
  Timestamp groupCreated;
  String currentBookId;
  Timestamp currentBookDue;

  MyGroup(
      {this.id,
      this.name,
      this.leader,
      this.members,
      this.groupCreated,
      this.currentBookId,
      this.currentBookDue});
}
