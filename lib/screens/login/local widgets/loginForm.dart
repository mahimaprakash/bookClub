import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/screens/signup/signup.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginType {
  email,
  google,
}

class MyLoginForm extends StatefulWidget {
  @override
  _MyLoginFormState createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser({
    @required LoginType type,
    String email,
    String password,
    BuildContext context,
  }) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString;

      switch (type) {
        case LoginType.email:
          _returnString =
              await _currentUser.loginUserWithEmail(email, password);

          break;
        case LoginType.google:
          _returnString = await _currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MyRoot(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_returnString),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _googleButton() {
    return OutlinedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        side: MaterialStateProperty.all(BorderSide(color: Colors.grey)),
      ),
      onPressed: () {
        _loginUser(type: LoginType.google, context: context);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/google.png"),
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Sign in with Google",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Login",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 15.0,
          ),
          ElevatedButton(
              onPressed: () {
                _loginUser(
                    type: LoginType.email,
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              )),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MySignup()));
            },
            //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Text(
              "Don't have an account? SignUp here",
            ),
          ),
          _googleButton(),
        ],
      ),
    );
  }
}
