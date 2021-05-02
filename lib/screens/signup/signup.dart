import 'package:bookclub/screens/signup/local%20widgets/signupForm.dart';
import 'package:flutter/material.dart';

class MySignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  BackButton(),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              MySignupForm(),
            ],
          ))
        ],
      ),
    );
  }
}
