import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/services/auth.dart';
import 'package:flutter/material.dart';

class InGroup extends StatefulWidget {
  @override
  InGroupState createState() => InGroupState();
}

class InGroupState extends State<InGroup> {
  List<String> _timeUntil = List<String>.filled(2, "0");

  //[0] - time until current book is due
  //[1] - time unitl next book is revealed

  // Timer _timer;

  // void _startTimer(CurrentGroup currentGroup) {
  //   _timer = Timer.periodic(Duration(minutes: 1), (timer) {
  //     setState(() {
  //       _timeUntil = MyTimeLeft()
  //           .timeLeft(currentGroup.getCurrentGroup.currentBookDue.toDate());
  //     });
  //   });
  // }

  @override
  // void initState() {
  //   super.initState();

  //   CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
  //   CurrentGroup _currentGroup =
  //       Provider.of<CurrentGroup>(context, listen: false);
  //   _currentGroup.updateStateFromDatabase(
  //       _currentUser.getCurrentUser.groupId, _currentUser.getCurrentUser.uid);
  //   _startTimer(_currentGroup);
  // }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  void _signOut(BuildContext context) async {
    String _returnString = await Auth().signOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyRoot(),
          ),
          (route) => false);
    }
  }

  // void _goToAddBook(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MyAddBook(
  //         onGroupCreation: false,
  //       ),
  //     ),
  //   );
  // }

  // void _goToReview() {
  //   CurrentGroup _currentGroup =
  //       Provider.of<CurrentGroup>(context, listen: false);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MyReview(
  //         currentGroup: _currentGroup,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ElevatedButton(
            child: Text("Signout"),
            onPressed: () => _signOut(context),
          ),
        ),
        body: ListView(
            //   children: <Widget>[
            //     SizedBox(
            //       height: 40.0,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child: MyContainer(child: Consumer<CurrentGroup>(
            //         builder: (BuildContext context, value, Widget child) {
            //           return Column(
            //             children: <Widget>[
            //               Text(
            //                 value.getCurrentBook.name ?? "loading..",
            //                 style: TextStyle(
            //                     fontSize: 25.0,
            //                     fontWeight: FontWeight.bold,
            //                     color: Color(0xFF206a5d)),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 20.0),
            //                 child: Row(
            //                   children: <Widget>[
            //                     Text(
            //                       "Due In:",
            //                       style: TextStyle(
            //                           fontSize: 20.0, color: Color(0xFF206a5d)),
            //                     ),
            //                     Expanded(
            //                       child: Text(
            //                         _timeUntil[0] ?? "loading..",
            //                         style: TextStyle(
            //                             fontSize: 20.0,
            //                             fontWeight: FontWeight.bold,
            //                             color: Color(0xFF206a5d)),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               ElevatedButton(
            //                   onPressed: () =>
            //                       value.getDoneWithCurrentBook ? null : _goToReview(),
            //                   child: Text(
            //                     "Finished Book",
            //                     style: TextStyle(color: Colors.white),
            //                   ))
            //             ],
            //           );
            //         },
            //       )),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child: MyContainer(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 20.0),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 "Next Book\nRevealed In:",
            //                 style:
            //                     TextStyle(fontSize: 20.0, color: Color(0xFF206a5d)),
            //               ),
            //               Text(
            //                 _timeUntil[1] ?? "loading..",
            //                 style: TextStyle(
            //                     fontSize: 20.0,
            //                     fontWeight: FontWeight.bold,
            //                     color: Color(0xFF206a5d)),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(50.0),
            //       child: ElevatedButton(
            //           onPressed: () => _goToAddBook(context),
            //           child: Text(
            //             "Book Club History",
            //             style: TextStyle(fontSize: 20.0),
            //           )),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //       child: ElevatedButton(
            //         onPressed: () => _signOut(context),
            //         child: Text(
            //           "Sign Out",
            //           style: TextStyle(fontSize: 20.0),
            //         ),

            //         // style: ButtonStyle(
            //         //   backgroundColor: MaterialStateProperty.all(Color(0xFFF8A488)),
            //         // ),
            //       ),
            //     )
            //   ],
            // ),
            ));
  }
}
