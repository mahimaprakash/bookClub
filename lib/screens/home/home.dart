import 'package:bookclub/screens/noGroup/noGroup.dart';
import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  void _signOut(BuildContext context) async {
    CurrentUser _currenUser = Provider.of<CurrentUser>(context, listen: false);

    String _returnString = await _currenUser.signOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyRoot(),
          ),
          (route) => false);
    }
  }

  void _goToNoGroup(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyNoGroup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyContainer(
                child: Column(
              children: <Widget>[
                Text(
                  "A Darker Shade of Magic",
                  style: TextStyle(fontSize: 25.0, color: Color(0xFF206a5d)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Due In:",
                        style:
                            TextStyle(fontSize: 20.0, color: Color(0xFF206a5d)),
                      ),
                      Text(
                        "8 Days",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF206a5d)),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Finished Book",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Next Book Revealed In:",
                      style:
                          TextStyle(fontSize: 20.0, color: Color(0xFF206a5d)),
                    ),
                    Text(
                      "23 Hours",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF206a5d)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ElevatedButton(
                onPressed: () => _goToNoGroup(context),
                child: Text(
                  "Book CLub History",
                  style: TextStyle(),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text("Sign Out"),
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(Color(0xFFF8A488)),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
