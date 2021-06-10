import 'package:bookclub/models/userModel.dart';
import 'package:bookclub/states/currentGroup.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyReview extends StatefulWidget {
  final CurrentGroup currentGroup;
  MyReview({this.currentGroup});
  @override
  _MyReviewState createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  TextEditingController _reviewController = TextEditingController();
  int _dropdownValue;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Rate book 1-10: "),
                      DropdownButton<int>(
                        value: _dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor),
                        underline: Container(
                          height: 2,
                          color: Colors.deepOrangeAccent,
                        ),
                        onChanged: (int newValue) {
                          setState(() {
                            _dropdownValue = newValue;
                          });
                        },
                        items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _reviewController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Add a review",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String uid =
                          Provider.of<UserModel>(context, listen: false).uid;

                      widget.currentGroup.finishedBook(
                          uid, _dropdownValue, _reviewController.text);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Add Review",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
