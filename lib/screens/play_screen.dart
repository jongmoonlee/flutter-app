import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  static const String id = 'play_screen';
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: Image.asset('images/yumdance.gif'),
                  height: 150.0,
                  padding: EdgeInsets.all(3)),
              Container(
                  child: Image.asset('images/yumdance_wide.gif'),
                  height: 220.0,
                  padding: EdgeInsets.all(3)),
            ],
          ),
        ));
  }
}
