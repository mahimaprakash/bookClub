import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;

  const MyContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Color(0xFFf8f5f1),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 6.0,
                spreadRadius: 1.0,
                offset: Offset(4.0, 4.0))
          ]),
      child: child,
    );
  }
}
