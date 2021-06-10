import 'package:bookclub/screens/addBook/addBook.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  void _goToAddBook(BuildContext context, String groupName) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddBook(onGroupCreation: true, groupName: groupName),
      ),
    );
  }

  TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [BackButton()],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: MyContainer(
              child: Column(
                children: [
                  TextFormField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _goToAddBook(context, _groupNameController.text),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Add Book",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
