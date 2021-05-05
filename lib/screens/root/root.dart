import 'package:bookclub/screens/home/home.dart';
import 'package:bookclub/screens/login/login.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus { notLoggedIn, loggedIn }

class MyRoot extends StatefulWidget {
  @override
  _MyRootState createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //get the state, check current user, set AuthStatus
    CurrentUser _currenUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currenUser.onStartUp();
    if (_returnString == "success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = MyLogin();
        break;
      case AuthStatus.loggedIn:
        retVal = HomeScreen();
        break;
      default:
    }
    return retVal;
  }
}
