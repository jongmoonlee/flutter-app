import 'package:flash_chat/screens/ante_quizroom_screen.dart';
import 'package:flash_chat/screens/play_screen.dart';
import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flash_chat/screens/todoList_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/buttons.dart';
import 'package:flash_chat/screens/quiz_screen.dart';

class AboutScreen extends StatelessWidget {
  static const String id = 'about_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 180.0,
              child: CircleAvatar(
                radius: 180.0, //
                backgroundColor: Colors.black,
                child: Image.asset('images/about_page.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50,top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Profile',
                    onPressed: () {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    },
                  ),
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Tricks',
                    onPressed: () {
                      Navigator.pushNamed(context, TodoListScreen.id);
                    },
                  ),
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Quiz',
                    onPressed: () {
                      Navigator.pushNamed(context, AnteQuizroomScreen.id);
                    },
                  ),
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Play',
                    onPressed: () {
                      Navigator.pushNamed(context, PlayScreen.id);
                    },
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
