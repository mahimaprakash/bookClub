import 'package:bookclub/services/auth.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';

class MySignupForm extends StatefulWidget {
  @override
  _MySignupFormState createState() => _MySignupFormState();
}

class _MySignupFormState extends State<MySignupForm> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signupUser(String email, String password, String fullName,
      BuildContext context) async {
    try {
      String _returnString = await Auth().signupUser(email, password, fullName);
      if (_returnString == "success") {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline), hintText: "User Name"),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
          ),
          SizedBox(
            height: 25.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open),
                hintText: "Confirm Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 25.0,
          ),
          ElevatedButton(
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signupUser(_emailController.text, _passwordController.text,
                    _fullNameController.text, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Passwords do not match"),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
              child: Text(
                "SIGNUP",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
