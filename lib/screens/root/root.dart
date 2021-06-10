import 'package:bookclub/models/authmodel.dart';
import 'package:bookclub/models/userModel.dart';
import 'package:bookclub/screens/ingroup/ingroup.dart';
import 'package:bookclub/screens/login/login.dart';
import 'package:bookclub/screens/noGroup/noGroup.dart';
import 'package:bookclub/screens/splashScreen/splashScreen.dart';
import 'package:bookclub/services/dbStream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  loggedIn,
}

class MyRoot extends StatefulWidget {
  @override
  _MyRootState createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;
  String currrentUid;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //get the state, check current user, set AuthStatus
    AuthModel _authStream = Provider.of<AuthModel>(context);
    if (_authStream != null) {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
        currrentUid = _authStream.uid;
      });
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
        retVal = SplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = MyLogin();
        break;
      case AuthStatus.loggedIn:
        retVal = StreamProvider<UserModel>.value(
          initialData: null,
          value: DbStream().getcurrentUser(currrentUid),
          child: LoggedIn(),
        );
        break;

      default:
    }
    return retVal;
  }
}

class LoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _userStream = Provider.of<UserModel>(context);
    Widget retVal;
    if (_userStream != null) {
      if (_userStream.groupId != null) {
        retVal = InGroup();
      } else {
        retVal = NoGroup();
      }
    } else {
      retVal = SplashScreen();
    }
    return retVal;
  }
}
