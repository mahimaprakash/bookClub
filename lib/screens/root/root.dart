import 'package:bookclub/screens/home/home.dart';
import 'package:bookclub/screens/login/login.dart';
import 'package:bookclub/screens/noGroup/noGroup.dart';
import 'package:bookclub/screens/splashScreen/splashScreen.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup,
}

class MyRoot extends StatefulWidget {
  @override
  _MyRootState createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //get the state, check current user, set AuthStatus
    CurrentUser _currenUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currenUser.onStartUp();
    if (_returnString == "success") {
      if (_currenUser.getCurrentUser.groupId != null) {
        setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notInGroup;
        });
      }
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = MySplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = MyLogin();
        break;
      case AuthStatus.notInGroup:
        retVal = MyNoGroup();
        break;
      case AuthStatus.inGroup:
        retVal = HomeScreen();
        break;
      default:
    }
    return retVal;
  }
}
