import 'package:bookclub/screens/createGroup/createGroup.dart';
import 'package:bookclub/screens/joinGroup/joinGroup.dart';
import 'package:bookclub/screens/login/login.dart';
import 'package:flutter/material.dart';

class NoGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => JoinGroup()));
    }

    void _goToCreate(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateGroup()));
    }

    void _goToLogin(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyLogin()));
    }

    return Scaffold(
      body: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.all(80.0),
            child: Image.asset("assets/Cheers.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Welcome to Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0, color: Color(0xFF206a5d)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Since you are not in a book club, you can select either " +
                  "the join a club or create a club",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Color(0xFF206a5d)),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _goToCreate(context),
                    child: Text("Create")),
                ElevatedButton(
                    onPressed: () => _goToJoin(context), child: Text("Join")),
                ElevatedButton(
                    onPressed: () => _goToLogin(context),
                    child: Text("go to login")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
