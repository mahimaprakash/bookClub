import 'package:bookclub/models/bookModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFuture {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createGroup(
      String groupName, String userUid, BookModel initialBook) async {
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

      //add a book
      addBook(_docRef.id, initialBook);

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

  // Future<MyGroup> getGroupInfo(String groupId) async {
  //   MyGroup retVal = MyGroup();
  //   try {
  //     DocumentSnapshot _docSnapshot =
  //         await _firestore.collection("groups").doc(groupId).get();

  //     retVal.id = groupId;
  //     retVal.name = _docSnapshot.data()["name"];
  //     retVal.leader = _docSnapshot.data()["leader"];
  //     retVal.members = List<String>.from(_docSnapshot.data()["members"]);
  //     retVal.groupCreated = _docSnapshot.data()["groupCreated"];
  //     retVal.currentBookId = _docSnapshot.data()["currentBookId"];
  //     retVal.currentBookDue = _docSnapshot.data()["currentBookDue"];
  //   } catch (e) {
  //     print(e);
  //   }
  //   return retVal;
  // }

  Future<String> addBook(String groupId, BookModel book) async {
    String retVal = "error";

    try {
      DocumentReference _docRef = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .add({
        'name': book.name,
        'author': book.author,
        'length': book.length,
        'completedOn': book.dateCompleted,
      });

      //add current book to group schedule
      await _firestore.collection("groups").doc(groupId).update(
          {'currentBookId': _docRef.id, "currentBookDue": book.dateCompleted});

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  // Future<MyBook> getCurrentBook(String groupId, String bookId) async {
  //   MyBook retVal = MyBook();
  //   try {
  //     DocumentSnapshot _docSnapshot = await _firestore
  //         .collection("groups")
  //         .doc(groupId)
  //         .collection("books")
  //         .doc(bookId)
  //         .get();

  //     retVal.id = bookId;
  //     retVal.name = _docSnapshot.data()["name"];
  //     retVal.author = _docSnapshot.data()["author"];
  //     retVal.length = _docSnapshot.data()["length"];
  //     retVal.dateCompleted = _docSnapshot.data()["dateCompleted"];
  //   } catch (e) {
  //     print(e);
  //   }
  //   return retVal;
  // }

  // Future<String> finishedBook(String groupId, String bookId, String uid,
  //     int rating, String review) async {
  //   String retVal = "error";
  //   try {
  //     await _firestore
  //         .collection("groups")
  //         .doc(groupId)
  //         .collection("books")
  //         .doc(bookId)
  //         .collection("reviews")
  //         .doc(uid)
  //         .set({'rating': rating, "review": review});
  //   } catch (e) {
  //     print(e);
  //   }
  //   return retVal;
  // }

  // Future<bool> isUserDoneWithBook(
  //     String groupId, String bookId, String uid) async {
  //   bool retVal = false;

  //   try {
  //     DocumentSnapshot _docSnapshot = await _firestore
  //         .collection("groups")
  //         .doc(groupId)
  //         .collection("books")
  //         .doc(bookId)
  //         .collection("reviews")
  //         .doc(uid)
  //         .get();

  //     if (_docSnapshot.exists) {
  //       retVal = true;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return retVal;
  // }

}
