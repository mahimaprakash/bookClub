import 'package:bookclub/models/book.dart';
import 'package:bookclub/models/group.dart';
import 'package:bookclub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();

      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data()["fullName"];
      retVal.email = _docSnapshot.data()["email"];
      retVal.accountCreated = _docSnapshot.data()["accountCreated"];
      retVal.groupId = _docSnapshot.data()["groupId"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> createGroup(String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = [];

    try {
      members.add(userUid);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'leader': userUid,
        'members': members,
        'groupCreatedAt': Timestamp.now()
      });

      await _firestore.collection("users").doc(userUid).update({
        'groupId': _docRef.id,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = [];
    try {
      members.add(userUid);
      await _firestore
          .collection("groups")
          .doc(groupId)
          .update({'members': FieldValue.arrayUnion(members)});

      await _firestore.collection("users").doc(userUid).update({
        'groupId': groupId,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<MyGroup> getGroupInfo(String groupId) async {
    MyGroup retVal = MyGroup();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("groups").doc(groupId).get();

      retVal.id = groupId;
      retVal.name = _docSnapshot.data()["name"];
      retVal.leader = _docSnapshot.data()["leader"];
      retVal.members = List<String>.from(_docSnapshot.data()["members"]);
      retVal.groupCreated = _docSnapshot.data()["groupCreated"];
      retVal.currentBookId = _docSnapshot.data()["currentBookId"];
      retVal.currentBookDue = _docSnapshot.data()["currentBookDue"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<MyBook> getCurrentBook(String groupId, String bookId) async {
    MyBook retVal = MyBook();
    try {
      DocumentSnapshot _docSnapshot = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .get();

      retVal.id = bookId;
      retVal.name = _docSnapshot.data()["name"];
      retVal.length = _docSnapshot.data()["length"];
      retVal.dateCompleted = _docSnapshot.data()["dateCompleted"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
