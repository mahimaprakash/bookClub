import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Sign Out"),
          onPressed: () async {
            CurrentUser _currenUser =
                Provider.of<CurrentUser>(context, listen: false);

            String _returnString = await _currenUser.signOut();
            if (_returnString == "success") {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRoot(),
                  ),
                  (route) => false);
            }
          },
        ),
      ),
    );
  }
}
