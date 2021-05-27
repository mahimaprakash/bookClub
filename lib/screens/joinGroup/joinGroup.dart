import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyJoinGroup extends StatefulWidget {
  @override
  _MyJoinGroupState createState() => _MyJoinGroupState();
}

class _MyJoinGroupState extends State<MyJoinGroup> {
  void _joinGroup(BuildContext context, String groupId) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString =
        await MyDatabase().joinGroup(groupId, _currentUser.getCurrentUser.uid);
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyRoot(),
          ),
          (route) => false);
    }
  }

  TextEditingController _groupIdController = TextEditingController();
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
                    controller: _groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Id",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          _joinGroup(context, _groupIdController.text),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: Text(
                          "Join",
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
