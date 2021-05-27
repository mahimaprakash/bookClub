import 'package:flutter/material.dart';

class MyNoGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _goToJoin() {}
    void _goToCreate() {}
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
                    onPressed: () => _goToCreate(), child: Text("Create")),
                ElevatedButton(
                    onPressed: () => _goToJoin(), child: Text("Join")),
              ],
            ),
          )
        ],
      ),
    );
  }
}