import 'package:flutter/material.dart';

class SplitScreen extends StatelessWidget {
  SplitScreen({Key key, @required this.split}) : super(key: key);
  final double split;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your split"),
        ),
        body: Center(
          child: Text(split.toString()),
        ),
      ),
    );
  }
}
