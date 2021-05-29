import 'package:bookclub/screens/addBook/addBook.dart';
import 'package:bookclub/screens/noGroup/noGroup.dart';
import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/states/currentGroup.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    CurrentGroup _currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);
    _currentGroup.updateStateFromDatabase(_currentUser.getCurrentUser.groupId);
  }

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

  void _goToAddBook(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyAddBook(
            onGroupCreation: false,
          ),
        ));
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
            child: MyContainer(child: Consumer<CurrentGroup>(
              builder: (BuildContext context, value, Widget child) {
                return Column(
                  children: <Widget>[
                    Text(
                      value.getCurrentBook.name ?? "loading..",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF206a5d)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Due In:",
                            style: TextStyle(
                                fontSize: 20.0, color: Color(0xFF206a5d)),
                          ),
                          Expanded(
                            child: Text(
                              (value.getCurrentGroup.currentBookDue != null)
                                  ? value.getCurrentGroup.currentBookDue
                                      .toDate()
                                      .toString()
                                  : "loading..",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF206a5d)),
                            ),
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
                );
              },
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
                onPressed: () => _goToAddBook(context),
                child: Text(
                  "Book Club History",
                  style: TextStyle(fontSize: 20.0),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 20.0),
              ),

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
