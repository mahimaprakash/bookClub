import 'package:bookclub/models/book.dart';
import 'package:bookclub/models/group.dart';
import 'package:bookclub/services/database.dart';
import 'package:flutter/cupertino.dart';

class CurrentGroup extends ChangeNotifier {
  MyGroup _currentGroup = MyGroup();
  MyBook _currentBook = MyBook();

  MyGroup get getCurrentGroup => _currentGroup;
  MyBook get getCurrentBook => _currentBook;

  void updateStateFromDatabase(String groupId) async {
    try {
      //get the group info from firebase
      _currentGroup = await MyDatabase().getGroupInfo(groupId);
      //get book info from firebase
      _currentBook = await MyDatabase()
          .getCurrentBook(groupId, _currentGroup.currentBookId);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
