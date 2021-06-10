import 'package:bookclub/models/authmodel.dart';
import 'package:bookclub/models/bookModel.dart';
import 'package:bookclub/models/userModel.dart';
import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/services/dbFuture.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  final bool onGroupCreation;
  final String groupName;
  final UserModel currentUser;
  AddBook({this.onGroupCreation, this.groupName, this.currentUser});

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked =
        await DatePicker.showDateTimePicker(context, showTitleActions: true);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addBook(BuildContext context, String groupName, BookModel book) async {
    AuthModel _currentUser = Provider.of<AuthModel>(context, listen: false);
    String _returnString;
    if (widget.onGroupCreation) {
      _returnString =
          await DbFuture().createGroup(groupName, _currentUser.uid, book);
    } else {
      _returnString =
          await DbFuture().addBook(widget.currentUser.groupId, book);
    }

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyRoot(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [BackButton()],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: MyContainer(
              child: Column(
                children: [
                  TextFormField(
                    controller: _bookNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.book),
                      hintText: "Book Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Author",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _lengthController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.pages),
                      hintText: "Length",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //datepicker
                  Text(DateFormat.yMMMMd("en_US").format(_selectedDate)),
                  Text(DateFormat("H:mm").format(_selectedDate)),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text("Change Date"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BookModel book = BookModel();
                      book.name = _bookNameController.text;
                      book.author = _authorController.text;
                      book.length = int.parse(_lengthController.text);
                      book.dateCompleted = _selectedDate as Timestamp;

                      _addBook(context, widget.groupName, book);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
