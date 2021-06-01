import 'package:bookclub/models/book.dart';
import 'package:bookclub/models/group.dart';
import 'package:bookclub/services/database.dart';
import 'package:flutter/cupertino.dart';

class CurrentGroup extends ChangeNotifier {
  MyGroup _currentGroup = MyGroup();
  MyBook _currentBook = MyBook();
  bool _doneWithCurrentBook = false;

  MyGroup get getCurrentGroup => _currentGroup;
  MyBook get getCurrentBook => _currentBook;
  bool get getDoneWithCurrentBook => _doneWithCurrentBook;

  void updateStateFromDatabase(String groupId, String userUid) async {
    try {
      //get the group info from firebase
      _currentGroup = await MyDatabase().getGroupInfo(groupId);
      //get book info from firebase
      _currentBook = await MyDatabase()
          .getCurrentBook(groupId, _currentGroup.currentBookId);
      _doneWithCurrentBook = await MyDatabase()
          .isUserDoneWithBook(groupId, _currentGroup.currentBookId, userUid);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void finishedBook(String userUid, int rating, String review) async {
    try {
      await MyDatabase().finishedBook(
          _currentGroup.id, _currentBook.id, userUid, rating, review);
      _doneWithCurrentBook = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
