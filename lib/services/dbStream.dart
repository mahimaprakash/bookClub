import 'package:bookclub/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbStream {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel> getcurrentUser(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(doc: docSnapshot));
  }
}
