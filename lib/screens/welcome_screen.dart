import 'package:flash_chat/screens/about_screen.dart';
import 'package:flash_chat/screens/todoList_screen.dart';
import 'package:flash_chat/screens/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';
import 'play_screen.dart';
import 'ante_chatroom_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser();
  FirebaseUser loggedInUser;
  bool isLoggedIn;

  void getCurrentUser() async {
    final loggedInUser = await _auth.currentUser();
    if (loggedInUser == null) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                      child: Image.asset('images/logo2.png'),
                      height: 150.0,
                      padding: EdgeInsets.all(3)),
                ),
                Center(
                  child: TextLiquidFill(
                    text: 'Tomichat',
//                    boxBackgroundColor: Colors.white,
                    waveColor: Colors.white,
                    textStyle: TextStyle(
                        fontSize: 45.0,
                        fontFamily: "PermanentMarker",
                        fontWeight: FontWeight.bold),
                    boxHeight: 100.0,
                    boxWidth: 250,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Material(
                    color: Colors.black54,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          color: Colors.white,
                          onPressed: () {
                            isLoggedIn
                                ? Navigator.pushNamed(context, LoginScreen.id)
                                : Navigator.pushNamed(
                                    context, AnteChatroomScreen.id);
                          },
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.black54,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.pets),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, AboutScreen.id);
                          },
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.black54,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.videogame_asset),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, PlayScreen.id);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}