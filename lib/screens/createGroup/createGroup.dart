import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCreateGroup extends StatefulWidget {
  @override
  _MyCreateGroupState createState() => _MyCreateGroupState();
}

class _MyCreateGroupState extends State<MyCreateGroup> {
  void _createGroup(BuildContext context, String groupName) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await MyDatabase()
        .createGroup(groupName, _currentUser.getCurrentUser.uid);
    if (_returnString == 'success') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyRoot(),
          ),
          (route) => false);
    }
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
          Spacer(),
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
                          _createGroup(context, _groupNameController.text),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Create",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
