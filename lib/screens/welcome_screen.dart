
import 'package:flash_chat/screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';
import 'ante_chatroom_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/buttons.dart';

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
//      print (loggedInUser.email);
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
                    waveColor: Colors.yellow,
                    textStyle: TextStyle(
                        fontSize: 45.0,
                        fontFamily: "PermanentMarker",
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconBtn(
                        bgColor: Colors.yellow,
                        iconColor: Colors.black,
                        size: 40,
                        icon: Icon(Icons.chat_bubble_outline),
                        onPressed: (){isLoggedIn
                            ? Navigator.pushNamed(context, LoginScreen.id)
                            : Navigator.pushNamed(
                            context, AnteChatroomScreen.id);}
                    ),
                      IconBtn(
                          iconColor: Colors.blue,
                          bgColor: Colors.white,
                          size: 40,
                          icon: Icon(Icons.pets),
                          onPressed: (){
                            Navigator.pushNamed(context, AboutScreen.id);
                          }),],
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




